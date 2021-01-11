#!/usr/bin/env bash

# This script gather a bunch of aws resource names, urls
# and arns and store all of that in a flat file.
# It is meant to be used with fzf to get easy fuzzy completion
# (coupled with some bindkey and zsh zle widget)

set -euo pipefail

echo_err() {
  echo "$@" >&2
}

cache_dir="${XDG_CONFIG_DIR:-${HOME}/.cache}/goustoaws"
mkdir -p "$cache_dir"

# default is 5, up to 10 because some operations
# like listing all cloudwatch log groups can be
# throttled
max_attempts="${AWS_MAX_ATTEMPTS:-10}"
export AWS_MAX_ATTEMPTS="$max_attempts"

if [[ $# -eq 0 ]] ; then
  profiles=("default")
else
  profiles=( "$@" )
fi

# reset all files
for f in "cloudwatch" "sqs" "sns" "s3" "rds" "ddb" "rds" "secretsmanager"
do
  path="${cache_dir}/$f.resource"
  true > "$path"
done

for profile in "${profiles[@]}"
do
  echo_err "For profile $profile"

  echo_err "* Cloudwatch log groups"
  p="${cache_dir}/cloudwatch.resource"
  aws --profile "$profile" logs describe-log-groups \
    | jq -r ".logGroups[] | .logGroupName" >> "$p"

  echo_err "* SQS queues urls"
  p="${cache_dir}/sqs.resource"
  aws --profile "$profile" sqs list-queues \
    | jq -r ".QueueUrls[]" >> "$p"

  echo_err "* SNS topics arns"
  p="${cache_dir}/sns.resource"
  aws --profile "$profile" sns list-topics \
    | jq -r ".Topics[] | .TopicArn" >> "$p"

  echo_err "* S3 buckets"
  p="${cache_dir}/s3.resource"
  aws --profile "$profile" s3 ls \
    | cut -d' ' -f 3 >> "$p"

  echo_err "* RDS instances endpoints"
  p="${cache_dir}/rds.resource"
  aws --profile "$profile" rds describe-db-instances \
    | jq -r ".DBInstances[] | .Endpoint.Address" >> "$p"

  echo_err "* DynamoDB table names"
  p="${cache_dir}/ddb.resource"
  aws --profile "$profile" dynamodb list-tables \
    | jq -r ".TableNames[]" >> "$p"

  echo_err "* Secrets manager"
  p="${cache_dir}/secretsmanager.resource"
  aws --profile "$profile" secretsmanager list-secrets \
    | jq -r ".SecretList[] | .Name" >> "$p"

  echo_err
done
