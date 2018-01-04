SELECT
  A.user_id AS user_id,
  A.link AS link,
  A.path,
  A.time,
  B.gender AS gender,
  B.mode,
  B.sum_dt AS activity_level
FROM (
  SELECT
    username,
    context.user_id as user_id,
    REGEXP_EXTRACT(event, r'(.*)current') AS link,
    page AS path,
    time
  FROM (TABLE_QUERY({course}_logs, "integer(regexp_extract(table_id, r'tracklog_([0-9]+)')) BETWEEN {table_date} and 20380101"))
  WHERE
    event_type == "edx.ui.lms.link_clicked"
    AND event NOT LIKE '%target_url": "https://courses.edx.org%'
    AND event NOT LIKE '%target_url": "https://www.edx.org/%'
    AND event NOT LIKE '%target_url": "https://studio.edx.org%'
    AND event NOT LIKE '%target_url": "https://preview.edx.org%'
    AND event NOT LIKE '%target_url": "https://courses.edge.edx.org%'
    AND event NOT LIKE '%target_url": "https://www.edge.edx.org/%'
    AND event NOT LIKE '%target_url": "https://studio.edge.edx.org%'
    AND event NOT LIKE '%target_url": "https://preview.edge.edx.org%'
    AND event NOT LIKE '%target_url": "javascript:void(0)%'
    AND time > PARSE_UTC_USEC("{date}")
  ORDER BY
    time) AS A
INNER JOIN
  [ubcxdata:{course}.person_course] AS B
ON
  A.user_id = B.user_id
WHERE
  B.sum_dt IS NOT NULL
LIMIT
  {limit}
