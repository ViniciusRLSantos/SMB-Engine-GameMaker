yy = lerp(yy, ystart, 0.2);
yy = clamp(yy, ystart-offset, ystart);

if !(instance_exists(oPlayer)) exit;

if (oPlayer.vspd <= 0 && place_meeting(x, y+1, oPlayer) && !place_meeting(x, y, oPlayer)) {
	if (!bonked) {
		var _enemy = instance_place(x, y-1, par_enemy);
		if (_enemy != noone) {
			with(_enemy) {
				if state != knocked_state {
					state = knocked_state;
					vspd = -2;
					audio_play_sound(sndKnock, 10, 0);
						
				}
			}
		}
		bonked = true;
		audio_play_sound(sndBump, 10, 0);
		spawnItem();
		yy -= offset;
		sprite_index = sBlockNull;
	}
}

if instance_exists(oShell) {
	with (oShell) {
		if place_meeting(x+hspd, y, other) && !other.bonked {
			var _enemy = instance_place(other.x, other.y-1, par_enemy);
			if (_enemy != noone) {
				with(_enemy) {
					if state != knocked_state {
						state = knocked_state;
						vspd = -2;
						audio_play_sound(sndKnock, 10, 0);
						
					}
				}
			}
			other.bonked = true;
			audio_play_sound(sndBump, 10, 0);
			other.spawnItem();
			other.yy -= other.offset;
			other.sprite_index = sBlockNull;
		}
	}
}