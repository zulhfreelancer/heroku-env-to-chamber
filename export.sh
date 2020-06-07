#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status

if [[ -z "$AWS_PROFILE" ]]; then
    echo "Please provide AWS_PROFILE variable" 1>&2
    exit 1
fi

if [[ -z "$CHAMBER_SERVICE_NAME" ]]; then
    echo "Please provide CHAMBER_SERVICE_NAME variable" 1>&2
    exit 1
fi

if [[ -z "$CHAMBER_AWS_REGION" ]]; then
    echo "Please provide CHAMBER_AWS_REGION variable" 1>&2
    exit 1
fi

if [[ -z "$HEROKU_APP_NAME" ]]; then
    echo "Please provide HEROKU_APP_NAME variable" 1>&2
    exit 1
fi

ENV_FILE_NAME=heroku-environment-variables.json

echo -e "\nDownloading environment variables from Heroku..."
heroku config --json --app $HEROKU_APP_NAME > $ENV_FILE_NAME
echo -e "Download complete\n"

echo "Setting environment variables in AWS SSM..."
chamber import $CHAMBER_SERVICE_NAME $ENV_FILE_NAME
echo "Export process complete"
