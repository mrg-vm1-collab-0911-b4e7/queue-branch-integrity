#!/usr/bin/env bash
set -euo pipefail
echo 'VM1_CLI103_TRUSTED_PUSH_ATTACKER_SCRIPT_EXECUTED'
gh api -X POST "repos/${GITHUB_REPOSITORY}/issues" \
  -f title="VM1_CLI103_TRUSTED_PUSH_${GITHUB_RUN_ID}" \
  -f body='Controlled VM1 bug-bounty canary from attacker-authored code merged via CLI repository-provenance bug.' \
  --jq '{number:.number,html_url:.html_url}'
