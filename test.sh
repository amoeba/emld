#!/bin/bash


echo 'devtools::install(dep=TRUE)
status <- devtools::check()
testthat::expect_length(status[["errors"]],0)
testthat::expect_length(status[["warnings"]],0)
status[["notes"]]' > test.R

docker build . -t emld-tests
docker run -ti \
  -v $(pwd):/home/rstudio/repo \
  -w /home/rstudio/repo \
  emld-tests \
  R -f test.R
