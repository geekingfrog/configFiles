#!/usr/bin/env bash

# This script gather a bunch of aws resource names, urls
# and arns and store all of that in a flat file.
# It is meant to be used with fzf to get easy fuzzy completion
# (coupled with some bindkey and zsh zle widget)

set -euo pipefail

echo_err() {
  echo "$@" >&2
}

cache_dir="${XDG_CONFIG_DIR:-${HOME}/.cache}"
mkdir -p "$cache_dir"
cache_file="${cache_dir}/aws-resources"

# clear the file
true > "$cache_file"

# profiles=${@:-("default")}

if [[ $# -eq 0 ]] ; then
  profiles=("default")
else
  profiles=( "$@" )
fi

for profile in "${profiles[@]}"
do
  echo_err "For profile $profile"

  echo_err "* Cloudwatch log groups"
  aws --profile "$profile" logs describe-log-groups \
    | jq -r ".logGroups[] | .logGroupName" >> "$cache_file"

  echo_err "* SQS queues urls"
  aws --profile "$profile" sqs list-queues \
    | jq -r ".QueueUrls[]" >> "$cache_file"

  echo_err "* SNS topics arns"
  aws --profile "$profile" sns list-topics \
    | jq -r ".Topics[] | .TopicArn" >> "$cache_file"

  echo_err "* S3 buckets"
  aws --profile "$profile" s3 ls \
    | cut -d' ' -f 3 >> "$cache_file"

  echo_err "* RDS instances endpoints"
  aws --profile "$profile" rds describe-db-instances \
    | jq -r ".DBInstances[] | .Endpoint.Address" >> "$cache_file"

  echo_err "* DynamoDB table names"
  aws --profile "$profile" dynamodb list-tables \
    | jq -r ".TableNames[]" >> "$cache_file"

  echo_err
done
