BATTERY=0
BATTERY_INFO=$(acpi -b | grep "Battery ${BATTERY}")
BATTERY_STATE=$(echo "${BATTERY_INFO}" | grep -wo "Full\|Charging\|Discharging")
BATTERY_POWER=$(echo "${BATTERY_INFO}" | grep -o '[0-9]\+%' | tr -d '%')
BATTERY_INFO=${BATTERY_INFO:11}
ARRAY=(${BATTERY_INFO//,/ })
BATTERY_TIME="${ARRAY[2]} ${ARRAY[3]}"

ICON=""
COLOR=""

if [[ "${BATTERY_STATE}" = "Charging" ]]; then
  	if [[ "${BATTERY_POWER}" -le 94 ]]; then
		ICON=""
  		COLOR="#FFFFFF"
	else
		ICON=""
  		COLOR="#55CC55"
	fi
elif [[ "${BATTERY_STATE}" = "Discharging" ]]; then
	if [[ "${BATTERY_POWER}" -le 10 ]]; then		
		# BATTERY < 10
		ICON=""
		COLOR="#AA2222"
	elif [[ "${BATTERY_POWER}" -le 25 ]]; then
		# 10 < BATTERY < 25
		ICON=""
		COLOR="#FFFFFF"
	elif [[ "${BATTERY_POWER}" -le 50 ]]; then
		# 25 < BATTERY < 50
		ICON=""
		COLOR="#FFFFFF"
	elif [[ "${BATTERY_POWER}" -le 75 ]]; then
		# 50 < BATTERY < 75
		ICON=""
		COLOR="#FFFFFF"
	else 
		# 75 < BATTERY
		ICON=""
		COLOR="#FFFFFF"
	fi
else
	ICON=""
  	COLOR="#FFFFFF"
fi

if [[ "${BLOCK_BUTTON}" -eq 1 ]]; then
	# Left Click - Time
	if [ "${ARRAY[3]}" == "at" ]; then
		BATTERY_TIME="${ARRAY[2]} ${ARRAY[3]} ${ARRAY[4]} ${ARRAY[5]}"
	fi
	notify-send $ICON "$BATTERY_TIME"
fi

echo "${ICON} ${BATTERY_POWER}%"
echo "${ICON} ${BATTERY_POWER}%"
echo $COLOR

# 
# 
# 
# 
# 
# 
