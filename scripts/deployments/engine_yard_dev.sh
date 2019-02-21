#!/bin/bash
# Deploy to Engine Yard via their CLI, https://www.engineyard.com/
#
# Add the following environment variables to your project configuration.
# * EY_API_TOKEN, e.g. "git@github.com:codeship/documentation.git"
# * EY_ENVIRONMENT, (optional)
# * EY_APP_URL, (optional, will be checked for a HTTP/2xx status code if provided
#
# Include in your builds via
# \curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/deployments/engine_yard.sh | bash -s
EY_API_TOKEN=${EY_API_TOKEN:?'You need to configure the EY_API_TOKEN environment variable!'}

set -e
ENVIRONMENT_PARAMETER=${EY_ENVIRONMENT_DEV:+"-e $EY_ENVIRONMENT_DEV"}
CHECK_URL_COMMAND=${EY_APP_URL_STAGING:+"check_url $EY_APP_URL_STAGING"}

gem install engineyard

echo ${ENVIRONMENT_PARAMETER}

ey init
ey deploy --ref ${CI_COMMIT_ID} --api-token "${EY_API_TOKEN}" ${ENVIRONMENT_PARAMETER}
${CHECK_URL_COMMAND}
