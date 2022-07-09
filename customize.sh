
[ -f /vendor/etc/thermal_info_config.json ] || abort "The system is not using pixel thermal, aborting"
grep -qi kyrielight /proc/version || abort "The system is not running on kyrielight, aborting"
