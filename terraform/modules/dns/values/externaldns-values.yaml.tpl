provider: cloudflare

cloudflare:
  email: "${cloudflare_email}"
  apiTokenSecretRef:
    name: "${secret_name}"
    key: "${token_key}"

policy: sync
registry: txt
txtOwnerId: aks-youtube-clone

domainFilters:
%{ for domain in domain_filters ~}
  - ${domain}
%{ endfor }

interval: 1m
sources:
  - ingress
