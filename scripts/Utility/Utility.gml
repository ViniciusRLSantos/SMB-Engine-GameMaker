function approach(from, to, amount) {
	if (from < to) {
		return min(to, from + amount);
	} else if (from > to) {
		return max(to, from - amount);
	} else {
		return to;
	}
}

function wave(from, to, duration, offset=0){
	a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + duration * offset) / duration) * (pi*2)) * a4;
}

function in_view_x(margin=0) {
	var cam = view_camera[0];
	var camX = camera_get_view_x(cam);
	var camW = camera_get_view_width(cam);
	
	return (self.x > camX-margin && self.x<camX+camW+margin )
}

function in_view_y(margin=0) {
	var cam = view_camera[0];
	var camY = camera_get_view_y(cam);
	var camH = camera_get_view_height(cam);
	
	return (self.y > camY-margin && self.y<camY+camH+margin )
}

function in_jumpthrough(check_under=0) {
	return collision_rectangle(x-sprite_get_width(sprite.collision_mask)/2, y-14, x+sprite_get_width(sprite.collision_mask)/2, y+check_under, oJumpthrough, false, false);
}

function floor_is_jumpthrough(check_under=0) {
	return collision_rectangle(x-sprite_get_width(sprite.collision_mask)/2, y, x+sprite_get_width(sprite.collision_mask)/2, y+check_under, oJumpthrough, false, false);
}

function kill_player() {
	if (!oPlayer.hit && oPlayer.state != player_death && oPlayer.y > self.y - sprite_height/2) {
		with(oPlayer) {
			hit = true;
			
			alarm[0] = HIT_TIMER;
					
			if (hp > 2) {
				audio_play_sound(sndPowerDown, 10, 0);
				powerUp = POWER.MARIOMUSH;
			} else if (hp == 2) {
				powerUp = noone;
				audio_play_sound(sndPowerDown, 10, 0);
			} else {
				audio_play_sound(sndDeath, 10, 0);
				vspd = jumpspd;
				oCamera.target = noone;
				state = player_death;
			}
		}
	}
}
