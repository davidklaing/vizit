#!/usr/bin/env bash

# Parse Config
SHORT=$1
GCLOUD=$2


if [ ! -d "../inst/data/$SHORT" ]; then
    mkdir ../inst/data/${SHORT}
fi

gsutil cp gs://ubcxdata/${GCLOUD}/xbundle_${GCLOUD}.xml ../inst/data/${SHORT}/xbundle.xml
gsutil cp gs://ubcxdata/${GCLOUD}/course_structure-prod-analytics.json.gz ../inst/data/${SHORT}/prod_analytics.json.gz
if [ $? != 0 ]; then
	 gsutil cp gs://ubcxdata/${GCLOUD}/course_structure-prod-edge-analytics.json.gz ../inst/data/${SHORT}/prod_analytics.json.gz
fi
gunzip -f ../inst/data/${SHORT}/prod_analytics.json.gz
