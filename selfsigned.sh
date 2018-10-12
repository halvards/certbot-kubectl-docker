#!/bin/sh

set -euf -o pipefail

DOMAIN=${1:-example.com}
NAMESPACE=${NAMESPACE:-default}
SECRET=${SECRET:-letsencrypt-certs}

openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
  -keyout privkey.pem -out cert.pem -subj "/CN=${DOMAIN}"

kubectl -n "${NAMESPACE}" create secret tls "${SECRET}" \
  --key privkey.pem --cert cert.pem \
  --dry-run -o yaml | kubectl apply -f -
