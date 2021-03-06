% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/video_wrangling.R
\name{get_watched_segments}
\alias{get_watched_segments}
\title{Returns original dataframe with segment columns}
\usage{
get_watched_segments(data)
}
\arguments{
\item{data}{Dataframe containing start and end columns. This dataframe is 
typically obtained through \code{get_start_end_df()}}
}
\value{
\code{data}: Original input dataframe with new segment columns
}
\description{
Returns original dataframe with segement columns. Segment 
  columns are 0 if the segment is not located within the start and end values
  and 1 otherwise.
}
\examples{
get_watched_segments(data = start_end_df)
}
