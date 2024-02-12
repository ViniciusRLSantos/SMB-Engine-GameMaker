yy += (y - yy)/10;
index += img_spd;

if !(instance_exists(oPlayer)) exit;

if (oPlayer.vspd <= 0 && place_meeting(x, y+1, oPlayer) && !place_meeting(x, y, oPlayer)) {
	oPlayer.vspd = 0;
	if (!flipping) {
		flipping = true;
		img_spd = 0.25;
		yy-=4;
		alarm[0] = room_speed*4;
		mask_index = noone;
		sprite_index = -1;
	}
}