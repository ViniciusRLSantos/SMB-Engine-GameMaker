yy = lerp(yy, ystart, 0.2);
yy = clamp(yy, ystart-offset, ystart);

if !(instance_exists(oPlayer)) exit;

if (oPlayer.vspd <= 0 && place_meeting(x, y+1, oPlayer) && !place_meeting(x, y, oPlayer)) {
	if (!bonked) {
		bonked = true;
		audio_play_sound(sndBump, 10, 0);
		spawnItem();
		yy -= offset;
		sprite_index = sBlockNull;
	}
}