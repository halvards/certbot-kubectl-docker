#!/bin/sh

set -euf -o pipefail

DOMAIN_LIST=${1}
EMAIL=${2}
STAGING=${3:-}
[[ ! -z "${STAGING}" ]] && STAGING="--staging"
DOMAIN=$(echo "${DOMAIN_LIST}" | sed 's/,.*//')
NAMESPACE=${NAMESPACE:-default}
SECRET=${SECRET:-letsencrypt-certs}

# (cat << EOF
# dns_cloudflare_email = ${CF_API_EMAIL}
# dns_cloudflare_api_key = ${CF_API_KEY}
# EOF
# ) > /etc/cloudflare.ini
# chmod 600 /etc/cloudflare.ini

echo certbot \
  --domains "${DOMAIN_LIST}" \
  --dns-cloudflare \
  --dns-cloudflare-propagation-seconds 60 \
  --dns-cloudflare-credentials /etc/cloudflare.ini \
  --preferred-challenges dns \
  --non-interactive \
  --agree-tos \
  --email "${EMAIL}" \
  --no-eff-email \
  --duplicate \
  "${STAGING}" \
  certonly

kubectl -n "${NAMESPACE}" create secret tls "${SECRET}" \
  --key "/etc/letsencrypt/live/${DOMAIN}/privkey.pem" \
  --cert "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" \
  --dry-run -o yaml | kubectl apply -f -
