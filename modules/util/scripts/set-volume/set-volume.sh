#!/usr/bin/env bash 

volume_step=5
max_volume=100
notification_timeout=1000

# Uses regex to get volume from pamixer
function get_volume {
	pamixer --get-volume
}

# Uses regex to get mute status from pamixer
function get_mute {
	pamixer --get-mute
}

# Returns a mute icon, a volume-low icon, or a volume-high icon, depending on the volume
function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ] ; then
        volume_icon=""
    elif [ "$volume" -lt 50 ]; then
        volume_icon=""
    else
        volume_icon=""
    fi
}

# Displays a volume notification
function show_volume_notif {
    volume=$(get_mute)
    get_volume_icon
	
	notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:"$volume" "$volume_icon $volume%"
}

# Main function - Takes user input, "volume_up", "volume_down", "brightness_up", or "brightness_down"
case $1 in
    volume_up)
    # Unmutes and increases volume, then displays the notification
	pamixer --unmute
    volume=$(get_volume)
    if [ $(( "$volume" + "$volume_step" )) -gt $max_volume ]; then
		pamixer --set-volume $max_volume
    else
		pamixer -i $volume_step
    fi
    show_volume_notif
    ;;

    volume_down)
    # Raises volume and displays the notification
	pamixer -d $volume_step
    show_volume_notif
    ;;

    volume_mute)
    # Toggles mute and displays the notification
    pamixer -t
    show_volume_notif
    ;;
esac
