# certbot-kubectl-docker

Create Let's Encrypt TLS certificates using `certbot` and a Cloudflare DNS
challenge, and store the private key and certificate chain as a Kubernetes TLS
secret.

Use the `selfsigned.sh` script to generate a self-signed certificate and store
it as a secret to get you started before the Let's Encrypt certificate is in
place.

Renewal information is not persisted, so each request for a new certificate is
a duplicate. Keep in mind the
[rate limits](https://letsencrypt.org/docs/rate-limits/)
for duplicate certificates when using this image.

It's a good idea to add the `--staging` argument to `certbot` when first
using this image to avoid hitting the rate limits if you make a configuration
mistake.

## Disclaimer

This is not an officially supported Google product.
