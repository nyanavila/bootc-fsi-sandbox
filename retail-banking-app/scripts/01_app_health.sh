#!/usr/bin/env bash
# File: retail-banking-app/scripts/01_app_health.sh

LOGGER_TAG="FSI-BOOTC-WATCHDOG"
HEALTH_URL="http://127.0.0.1:8080"
MAX_ATTEMPTS=3
SLEEP_INTERVAL=5

logger -t "$LOGGER_TAG" "Initiating post-boot synthetic endpoint verification..."

for ((attempt=1; attempt<=MAX_ATTEMPTS; attempt++)); do
    # Simulating a check for application readiness
    if curl -s --max-time 2 "$HEALTH_URL" > /dev/null; then
        logger -t "$LOGGER_TAG" "SUCCESS: Application Layer initialized perfectly."
        exit 0
    fi
    logger -t "$LOGGER_TAG" "Polling application... (Attempt $attempt/$MAX_ATTEMPTS)"
    sleep "$SLEEP_INTERVAL"
done

logger -t "$LOGGER_TAG" "CRITICAL ERROR: Application failed to initialize. Triggering Rollback."
exit 1
