#!/bin/sh

set -e

default_output_file_name=/result.json

if [ "$1" = "" ]; then
  echo "out file name not supplied, using default value $default_output_file_name"
  export OUTPUT_FILE=$default_output_file_name
else
  export OUTPUT_FILE=$1
fi

set -u

export TEST_RESULTS_NAME=my-benchmark-result
# install and run the tests
phoronix-test-suite batch-benchmark my-benchmark
exec phoronix-test-suite result-file-to-json "$TEST_RESULTS_NAME"
