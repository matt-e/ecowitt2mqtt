#!/bin/bash
if [ -z "${MQTT_BROKER}" ]; then
    echo "Missing required environment variable: MQTT_BROKER"
    exit 1
fi

if [ -z "${MQTT_TOPIC}" ] && [ "${HASS_DISCOVERY}" != "true" ]; then
    echo "Missing required environment variable: either MQTT_TOPIC or HASS_DISCOVERY"
    exit 1
fi

PARAMS=(--mqtt-broker="${MQTT_BROKER}" --mqtt-topic="${MQTT_TOPIC}")

if [ -n "${LOG_LEVEL}" ]; then
    PARAMS+=(--log-level="${LOG_LEVEL}")
fi

if [ -n "${MQTT_PORT}" ]; then
    PARAMS+=(--mqtt-port="${MQTT_PORT}")
fi

if [ -n "${MQTT_USERNAME}" ]; then
    PARAMS+=(--mqtt-username="${MQTT_USERNAME}")
fi

if [ -n "${MQTT_PASSWORD}" ]; then
    PARAMS+=(--mqtt-password="${MQTT_PASSWORD}")
fi

if [ "${HASS_DISCOVERY}" = "true" ]; then
    PARAMS+=(--hass-discovery)
fi

if [ -n "${HASS_DISCOVERY_PREFIX}" ]; then
    PARAMS+=(--hass-discovery-prefix="${HASS_DISCOVERY_PREFIX}")
fi

if [ -n "${HASS_EXPIRE_AFTER}" ]; then
    PARAMS+=(--hass-expire-after="${HASS_EXPIRE_AFTER}")
fi

if [ "${HASS_FORCE_UPDATE}" = "true" ]; then
    PARAMS+=(--hass-force-update)
fi

if [ -n "${ENDPOINT}" ]; then
    PARAMS+=(--endpoint="${ENDPOINT}")
fi

if [ -n "${PORT}" ]; then
    PARAMS+=(--port="${PORT}")
fi

if [ "${RAW_DATA}" = "true" ]; then
    PARAMS+=(--raw-data)
fi

if [ -n "${INPUT_UNIT_SYSTEM}" ]; then
    PARAMS+=(--input-unit-system="${INPUT_UNIT_SYSTEM}")
fi

if [ -n "${OUTPUT_UNIT_SYSTEM}" ]; then
    PARAMS+=(--output-unit-system="${OUTPUT_UNIT_SYSTEM}")
fi

python3 /usr/src/ecowitt2mqtt/main.py "${PARAMS[@]}"
