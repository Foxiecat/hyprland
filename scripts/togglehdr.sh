#!/usr/bin/env bash

MONITOR="$1"
CURRENT=$(hyprctl -j monitors | jq -r '.[] | select(.name == "DP-1") | .colorManagementPreset')

if [ "$CURRENT" = "hdredid" ]; then
  hyprctl keyword "monitorv2[${MONITOR}]:cm" edid
  notify-send "HDR" "HDR Disabled"
else
  hyprctl keyword "monitorv2[${MONITOR}]:cm" hdredid
  notify-send "HDR" "HDR Enabled"
fi
