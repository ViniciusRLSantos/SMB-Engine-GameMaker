if instance_exists(oPlayer) {
	with (oPlayer) {
		if (place_meeting(x, y-1, other) && !place_meeting(x, y, other)) {
			vspd = 0;
		}
	}
}