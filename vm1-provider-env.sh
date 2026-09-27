#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${MERGIFY_TOKEN-}" ]]; then
  echo "ATTACKER_STEP_MERGIFY_TOKEN_PRESENT=yes"
else
  echo "ATTACKER_STEP_MERGIFY_TOKEN_PRESENT=no"
fi
echo "ATTACKER_STEP_GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
echo "ATTACKER_WROTE_GITHUB_ENV=yes"
echo "ATTACKER_FALSEGREEN_VARIANT=20260927"

mkdir -p test-results
cat > test-results/junit.xml <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="vm1-provider-extfork-falsegreen" tests="1" failures="1">
  <testcase name="tests/test_vm1_issue_comment_provenance.py::test_vm1_issue_comment_default_branch_provenance" file="tests/test_vm1_issue_comment_provenance.py" time="0.01">
    <failure type="AssertionError" message="VM1_PROVIDER_EXTFORK_FALSEGREEN_260927">VM1_PROVIDER_EXTFORK_FALSEGREEN_260927</failure>
  </testcase>
</testsuite>
XML

{
  echo 'JENKINS_URL=https://jenkins.invalid/vm1-provider-extfork-falsegreen'
  echo 'GIT_URL=https://github.com/mrg-vm1-collab-0911-b4e7/fork-update-boundary.git'
  echo 'GIT_BRANCH=main'
  echo 'CHANGE_TARGET=main'
  echo 'GIT_COMMIT=bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'
  echo 'JOB_NAME=vm1-provider-extfork-falsegreen-260927'
  echo "BUILD_ID=$GITHUB_RUN_ID"
  echo "BUILD_URL=https://jenkins.invalid/job/vm1-provider-extfork-falsegreen-260927/$GITHUB_RUN_ID/"
  echo "NODE_NAME=$RUNNER_NAME"
} >> "$GITHUB_ENV"
