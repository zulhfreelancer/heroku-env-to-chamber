## About

A helper script to export all environment variables from a Heroku app to AWS SSM Parameter Store using Heroku CLI and Chamber CLI

## Chamber?

[This](https://aws.amazon.com/blogs/mt/the-right-way-to-store-secrets-using-parameter-store/) a good read for you. The Chamber CLI source code is available [here](https://github.com/segmentio/chamber).

## Requirements

- [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
- [Chamber v2 CLI](https://github.com/segmentio/chamber/releases/tag/v2.8.2)

## Usage

```
$ AWS_PROFILE=see_notes \
  CHAMBER_SERVICE_NAME=see_notes \
  CHAMBER_AWS_REGION=see_notes \
  HEROKU_APP_NAME=see_notes \
  ./export.sh
```

- `AWS_PROFILE` - Run `cat ~/.aws/credentials` and set this value to match a square bracket value inside that file (without [] symbols). The IAM user behind this profile should have write permissions to AWS SSM Parameter Store. You may use and customize an IAM policy based on this [sample policy](https://gist.github.com/zulhfreelancer/1b17a567d0b14ce11f3369bb8427bdc7).

- `CHAMBER_SERVICE_NAME` - Think of this like a namespace for all your environment variables in AWS SSM Parameter Store later. In Chamber lingo, it's called 'service'.

- `CHAMBER_AWS_REGION` - In which AWS region you want to store the new environment variables? Get it from [here](https://docs.aws.amazon.com/general/latest/gr/rande.html#regional-endpoints). Ideally, the AWS SSM Parameter Store should be in the same region with your other workloads.

- `HEROKU_APP_NAME` - Set this to your Heroku app name that you want to pull environment variables from. From example, let say your Heroku app URL is `blog-app.herokuapp.com`, you should use `blog-app` for this variable.

## Example

```
$ AWS_PROFILE=my-aws-profile-name \
  CHAMBER_SERVICE_NAME=blog-app \
  CHAMBER_AWS_REGION=ap-southeast-1 \
  HEROKU_APP_NAME=blog-app \
  ./export.sh

Downloading environment variables from Heroku...
Download complete

Setting environment variables in AWS SSM...
Successfully imported 10 secrets
Export process complete
```

## FYI

- This script will only work if you want to set NEW variables in AWS SSM. If those variables have been added, this script won't run successfully. You may need to use `chamber write` command and it's not covered inside this script.
- If you need to delete all keys for a service, you may use [this script](https://gist.github.com/zulhfreelancer/083506f0d992ba66976ee6b2aefad6c0).
