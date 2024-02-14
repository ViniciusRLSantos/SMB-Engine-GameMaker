yy = lerp(yy, ystart, 0.20);
yy = clamp(yy, ystart-offset, ystart);

index += img_spd;

if !(instance_exists(oPlayer)) exit;

if (oPlayer.vspd <= 0 && place_meeting(x, y+1, oPlayer) && !place_meeting(x, y, oPlayer)) {
	if (oPlayer.block_strength < 2) {
		if (!bonked) {
			bonked = true;
			audio_play_sound(sndBump, 10, 0);
			alarm[0] = 10
			yy-=offset;
		}
	} else {
		instance_destroy();
	}
}

if instance_exists(oShell) {
	with (oShell) {
		if place_meeting(x+hspd, y, other) && !other.bonked {
			instance_destroy(other);
			dir *= -1;
		}
	}
}