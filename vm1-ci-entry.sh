#!/usr/bin/env bash
set -euo pipefail
if [ -z "${VM1_MQ_SENTINEL:-}" ]; then
  echo "sentinel missing" >&2
  exit 91
fi
secret_hash=$(printf '%s' "$VM1_MQ_SENTINEL" | sha256sum | awk '{print $1}')
marker="vm1-mq-trusted-write-${GITHUB_RUN_ID}"
git config user.name 'VM1 MQ trusted-context proof'
git config user.email 'vm1-mq-proof@example.invalid'
git checkout -B "$marker"
printf 'secret_sha256=%s\nsource_sha=%s\nactor=%s\nrepository=%s\n' "$secret_hash" "$GITHUB_SHA" "$GITHUB_ACTOR" "$GITHUB_REPOSITORY" > VM1_MQ_TRUSTED_CONTEXT_PROOF.txt
git add VM1_MQ_TRUSTED_CONTEXT_PROOF.txt
git commit -m 'VM1 trusted push context proof'
git push origin "HEAD:refs/heads/$marker"
echo "marker_branch=$marker" >> "$GITHUB_STEP_SUMMARY"
