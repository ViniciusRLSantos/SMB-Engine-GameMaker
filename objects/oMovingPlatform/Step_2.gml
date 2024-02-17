
if instance_exists(oPlayer) {
	with (oPlayer) {
		if (place_meeting(x, y+1, other) && !place_meeting(x, y, other)) {
			if !(other.activated) {
				other.activated = true;
				other.alarm[0] = other.time_to_activate;
			}
		}
	}
}