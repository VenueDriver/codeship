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
ROLLBAR_ACCESS_TOKEN=${ROLLBAR_ACCESS_TOKEN:?'You need to configure the ROLLBAR_ACCESS_TOKEN environment variable!'}
ENVIRONMENT=$CI_BRANCH
LOCAL_USERNAME=`whoami`
REVISION=`git rev-parse --verify HEAD`
curl https://api.rollbar.com/api/1/deploy/ \
  -F access_token=$ROLLBAR_ACCESS_TOKEN \
  -F environment=$ENVIRONMENT \
  -F revision=$CI_COMMIT_ID \
  -F local_username=$LOCAL_USERNAME
