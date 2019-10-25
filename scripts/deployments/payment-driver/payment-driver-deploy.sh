#!/bin/sh
if [ $CI_BRANCH == "master" ]; then export CI_BRANCH="production"; fi
if [ $CI_BRANCH == "staging" ]; then export STRIPE_PUBLISHABLE_KEY="${STRIPE_PUBLISHABLE_KEY_STAGING}"; export STRIPE_SECRET_KEY="${STRIPE_SECRET_KEY_STAGING}"; fi
echo ${STRIPE_PUBLISHABLE_KEY}
echo ${STRIPE_SECRET_KEY}
npm run publish -- --skip-coverage --stage ${CI_BRANCH} --verbose --stop-on-error
