#!/bin/bash

THE_DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "Build started on $THE_DATE"

appenvsubstr(){
    p_template=$1
    p_destination=$2
    envsubst '$TF_VAR_ENV_APP_GL_NAME' < $p_template \
    | envsubst '$TF_VAR_ENV_APP_GL_STAGE' \
    | envsubst '$TF_VAR_ENV_APP_BE_NAMESPACE' \
    | envsubst '$TF_VAR_ENV_APP_BE_LOCAL_SOURCE_FOLDER' \
    | envsubst '$TF_VAR_ENV_APP_BE_LOCAL_PORT' \
    | envsubst '$TF_VAR_ENV_APP_BE_URL' \
    | envsubst '$TF_VAR_ENV_APP_DB_HOST' \
    | envsubst '$TF_VAR_ENV_APP_DB_NAME' \
    | envsubst '$TF_VAR_ENV_APP_DB_USERNAME' \
    | envsubst '$TF_VAR_ENV_APP_DB_PASSWORD' \
    | envsubst '$TF_VAR_ENV_APP_DB_PORT' \
    | envsubst '$TF_VAR_ENV_APP_GL_NAMESPACE' \
    | envsubst '$TF_VAR_ENV_APP_GL_AWS_ACCOUNT_ID' \
    | envsubst '$TF_VAR_ENV_APP_GL_AWS_REGION' \
    | envsubst '$TF_VAR_ENV_APP_GL_SCRIPT_MODE' \
    | envsubst '$TF_VAR_ENV_APP_BE_EKS_CLUSTER_NAME' \
    | envsubst '$TF_VAR_ENV_APP_BE_DOMAIN_NAME' \
    | envsubst '$TF_VAR_ENV_APP_BE_SSL_CERT_ARN' \
    | envsubst '$TF_VAR_ENV_APP_GL_REPO_JDK_NAME' \
    | envsubst '$TF_VAR_ENV_APP_GL_REPO_JDK_TAG' \
    | envsubst '$TF_VAR_ENV_APP_GL_AWS_REGION_ECR' > $p_destination
}

appenvsubstr devops/appspec.yml.template appspec.yml
appenvsubstr devops/appspec.sh.template devops/appspec.sh
chmod 777 devops/appspec.sh
