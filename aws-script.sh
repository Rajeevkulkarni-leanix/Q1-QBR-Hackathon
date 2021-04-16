#!/bin/bash

AUTH_URL=https://${LEANIX_HOST}/services/mtm/v1/oauth2/token
URL=https://${LEANIX_HOST}/services/cicd-connector/v2/deployment

FILE="`pwd`/metadata.yaml"
BEARER=$(curl ${AUTH_URL} -u apitoken:${LEANIX_TOKEN} --data grant_type=client_credentials | jq -r '.access_token') 
echo $(curl -H "Authorization: Bearer $BEARER" -H 'Content-Type: multipart/form-data' -F manifest="@$FILE" -F 'data={"version": "1.0.0", "stage": "dev"}' $URL)
