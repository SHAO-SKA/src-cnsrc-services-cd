#!/bin/bash

# Prerequisites: Make sure this file exists in your RSE at the following path:
#                /<your_RSE>/testing/5b/f5/PTF10tce.fits
#                If not, verify the correct path and update it in the SODA and PrepareData sections below.
#                (!) Other RSEs may use a different path


# Add your own or other endpoints to test.

ECHO_ENDPOINTS=(
  "https://gatekeeper.ska.zverse.space/echo?id=health"
  "https://src.canfar.net/echo?id=health"
)

SODA_ENDPOINTS=(
  "https://gatekeeper.ska.zverse.space/soda/ska/datasets/soda"
  "https://src.canfar.net/soda/ska/datasets/soda"
)

PREPAREDATA_ENDPOINTS=(
  "https://gatekeeper.ska.zverse.space/preparedata/"
  "https://src.canfar.net/preparedata/" 
)


# Colors for output
GREEN="✅"
RED="❌"

# Generate random suffix
RANDOM_ID=$RANDOM
CLIENT_NAME="gk$RANDOM_ID"

# Run OIDC agent setup
echo -e "\n🔐 Starting OIDC setup...\n"

eval $(oidc-agent) && echo -e "$GREEN oidc-agent started" || { echo -e "$RED Failed to start oidc-agent"; exit 1; }
eval $(oidc-agent-service use) && echo -e "$GREEN oidc-agent-service loaded" || { echo -e "$RED Failed to use oidc-agent-service"; exit 1; }

# Generate credentials
oidc-gen --iss=https://ska-iam.stfc.ac.uk --scope max --flow=device "$CLIENT_NAME"
[[ $? -eq 0 ]] && echo -e "$GREEN oidc-gen succeeded" || { echo -e "$RED oidc-gen failed"; exit 1; }

# Export token
export SKA_TOKEN=$(oidc-token "$CLIENT_NAME")
[[ -n "$SKA_TOKEN" ]] && echo -e "$GREEN SKA_TOKEN exported" || { echo -e "$RED Failed to export SKA_TOKEN"; exit 1; }

#######################################
# ECHO TESTS
#######################################

echo -e "\n🌐 Testing echo endpoints...\n"


for url in "${ECHO_ENDPOINTS[@]}"; do
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -XGET "$url" \
       -H "Authorization: Bearer $SKA_TOKEN")

  if [[ "$RESPONSE_CODE" == "200" ]]; then
    echo -e "$GREEN $url returned 200"
  else
    echo -e "$RED $url failed with $RESPONSE_CODE"
  fi
done

#######################################
# SODA TESTS
#######################################

echo -e "\n📡 Testing SODA endpoints...\n"

for soda_url in "${SODA_ENDPOINTS[@]}"; do
  domain=$(echo "$soda_url" | sed -E 's|https?://([^/]+).*|\1|')
  curl -s -k --get \
       -H "Authorization: Bearer $SKA_TOKEN" \
       --data-urlencode "ID=ivo://auth.example.org/datasets/fits?testing/5b/f5/PTF10tce.fits" \
       --data-urlencode "CIRCLE=351.986728 8.778684 0.01" \
       --data-urlencode "RESPONSE_FORMAT=application/fits" \
       -o "/tmp/output_${domain}.fits" \
       "$soda_url"

  CODE=$?
  MIME=$(file --mime-type -b /tmp/output_${domain}.fits)

echo -e "\n📡 got result mime $MIME"

  if [[ $CODE -eq 0 && "$MIME" == "image/fits" ]]; then
    echo -e "$GREEN $soda_url succeeded and file /tmp/output_${domain}.fits is FITS (image/fits)"
  elif [[ $CODE -eq 0 && "$MIME" == "application/octet-stream" ]]; then
    echo -e "$GREEN $soda_url succeeded and file /tmp/output_${domain}.fits is FITS (application/octet-stream)"
  else
    echo -e "$RED $soda_url failed or file /tmp/output_${domain}.fits is not FITS (mime: $MIME)"
  fi
done

#######################################
# PREPARE DATA TESTS
#######################################

echo -e "\n🛠️ Testing preparedata endpoints...\n"

for pdata_url in "${PREPAREDATA_ENDPOINTS[@]}"; do
  RESP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$pdata_url" \
       -H "Authorization: Bearer $SKA_TOKEN" \
       -H 'accept: application/json' \
       -H 'Content-Type: application/json' \
       -d '[[ "testing:PTF10tce.fits","testing/5b/f5/PTF10tce.fits","./testing"]]')

  if [[ "$RESP_CODE" == "200" ||  "$RESP_CODE" == "201" ]]; then
    echo -e "$GREEN $pdata_url returned 200/201"
  else
    echo -e "$RED $pdata_url failed with $RESP_CODE"
  fi
done
