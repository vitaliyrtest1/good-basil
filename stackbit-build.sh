#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://stg-api.stackbit.com/project/5de61f38b6920d00139722fd/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://stg-api.stackbit.com/pull/5de61f38b6920d00139722fd 
fi
curl -s -X POST https://stg-api.stackbit.com/project/5de61f38b6920d00139722fd/webhook/build/ssgbuild > /dev/null
jekyll build
curl -s -X POST https://stg-api.stackbit.com/project/5de61f38b6920d00139722fd/webhook/build/publish > /dev/null
