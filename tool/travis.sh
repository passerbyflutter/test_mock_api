#!/bin/bash

# Fast fail the script on failures.
set -e

dart --checked test/dashboard_api_test.dart

# Install dart_coveralls; gather and send coverage data.
if [ "$COVERALLS_TOKEN" ] && [ "$TRAVIS_DART_VERSION" = "stable" ]; then
  echo "Running coverage..."
  dart bin/dashboard_api.dart report \
    --retry 2 \
    --exclude-test-files \
    --throw-on-error \
    --throw-on-connectivity-error \
    --debug \
    test/dashboard_api_test.dart
  echo "Coverage complete."
else
  if [ -z ${COVERALLS_TOKEN+x} ]; then echo "COVERALLS_TOKEN is unset"; fi
  if [ -z ${TRAVIS_DART_VERSION+x} ]; then
    echo "TRAVIS_DART_VERSION is unset";
  else
    echo "TRAVIS_DART_VERSION is $TRAVIS_DART_VERSION";
  fi

  echo "Skipping coverage for this configuration."
fi