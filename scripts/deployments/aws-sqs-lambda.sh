#!/bin/sh
if [ $CI_BRANCH == "master" ]; then export CI_BRANCH="production"; fi
if [ $CI_BRANCH == "master" ]; then export HOST="https://vd2.venuedriver.com:443/api/v2/payments"; fi
echo ${HOST}
export BUCKET_NAME="sqs-payments-${CI_BRANCH}.venuedriver.engineering"
export STACK_NAME="${STACK_NAME}-${CI_BRANCH}"
aws s3 mb s3://${BUCKET_NAME}
sam build
sam package --template-file .aws-sam/build/template.yaml  --output-template-file ${CI_BRANCH}-packaged.yaml --s3-bucket ${BUCKET_NAME}
sam deploy --template-file ${CI_BRANCH}-packaged.yaml --stack-name ${STACK_NAME} --capabilities CAPABILITY_IAM --parameter-overrides Token=${TOKEN} Environment=${CI_BRANCH} Host=${HOST} Stack=${STACK_NAME}
