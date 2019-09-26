#!/bin/sh

aws s3 mb s3://${BUCKET_NAME}
sam build
sam package --template-file .aws-sam/build/template.yaml  --output-template-file ${CI_BRANCH}-packaged.yaml --s3-bucket ${BUCKET_NAME}
sam deploy --template-file ${CI_BRANCH}-packaged.yaml --stack-name ${STACK_NAME}-${CI_BRANCH} --capabilities CAPABILITY_IAM --parameter-overrides Token=${TOKEN} Environment=${CI_BRANCH} Host=${HOST} Stack=${STACK_NAME}
