#/usr/bin/env bash

# Author: contact@cloudastic.co
# Version: 0.1

# Examples:
# ./local-cf-deploy.sh -e sandbox -s 

set -o errexit 
set -o pipefail 
set -o nounset 
set -o xtrace 

usage() { echo "Usage: $0 [-e <environment>] [-l <cloudformation infrastructure layer>]" 1>&2; exit 1; }

while getopts ":e:l:" o; do
  case ${o} in
    e) 
		e=${OPTARG}
		;;
    l) 
		l=${OPTARG}
		;;     
    *) 
		usage
		;;
  esac
done
shift $((OPTIND-1)) 

if [ -z "${e}" ] || [ -z "${l}" ]; then
    usage
fi

environment=${e}
cf_infra_layer=${l}


if [[ "${environment}" == "global" ]]
then
    echo "Deploying global infrastructure"
    aws cloudformation deploy \
    --stack-name ${environment}-${cf_infra_layer} \
    --template-file infrastructure/global/${cf_infra_layer}.yaml \
    --parameter-overrides $(cat parameters/global/${cf_infra_layer}.ini) \
    --tags $(cat parameters/global/tags.ini)     
else
    echo "Deploying ${environment} infrastructure"
    aws cloudformation deploy \
    --stack-name ${environment}-${cf_infra_layer} \
    --template-file infrastructure/environment/${cf_infra_layer}.yaml \
    --parameter-overrides $(cat parameters/environments/${environment}/${cf_infra_layer}.ini) \
    --tags $(cat parameters/environments/${environment}/tags.ini) \
    --region eu-west-1
fi

#TODO add delete stack flag

