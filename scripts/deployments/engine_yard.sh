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

# set environment and account dynamically based on branch from codeship
if [ $CI_BRANCH == "master" ] ; then
ENVIRONMENT_PARAMETER="php_production"
ACCOUNT_PARAMETER=${EY_ACCOUNT_PRODUCTION}
elif [ $CI_BRANCH == "dev" ] ; then
ENVIRONMENT_PARAMETER="php_development"
ACCOUNT_PARAMETER=${EY_ACCOUNT_DEV}
elif [ $CI_BRANCH == "staging" ] ; then
ENVIRONMENT_PARAMETER="php_staging"
ACCOUNT_PARAMETER=${EY_ACCOUNT_STAGING}
fi

#ENVIRONMENT_PARAMETER=${EY_ENVIRONMENT:+"-e $EY_ENVIRONMENT"}
CHECK_URL_COMMAND=${EY_APP_URL:+"check_url $EY_APP_URL"}

gem install engineyard

#echo -e ${ENVIRONMENT_PARAMETER}

ey init
ey deploy --ref ${CI_COMMIT_ID} --api-token "${EY_API_TOKEN}" --environment "${ENVIRONMENT_PARAMETER}" --account "${ACCOUNT_PARAMETER}"
${CHECK_URL_COMMAND}
