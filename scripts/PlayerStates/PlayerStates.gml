#region General Mario States
function player_ground() {
	get_inputs();
	move = kRight - kLeft;
	spd = minspd*(!kRun) + maxspd*kRun;
	if (move != 0) {	
		dir = move;
		if (move <> sign(hspd)) {
			if (hspd != 0)  {
				sprite_index = sprite.turn;
				if !(audio_is_playing(sndSkid)) audio_play_sound(sndSkid, 10, 0);
				if !layer_exists("SkidParticle") layer_create(-100, "SkidParticle")
				var _p = part_system_create(partSkid);
				part_system_layer(_p, "SkidParticle");
				part_system_position(_p, x, y);
			}
		} else {
			image_speed = abs(hspd)/spd;
			if abs(hspd) == maxspd {
				sprite_index = sprite.run;
				running = true;
			} else {
				sprite_index = sprite.walk;
				running = false;
			}
		}
		hspd = approach(hspd, spd*move, acc_g);
	} else {
		hspd = approach(hspd, 0, fric_g);
		running = false;
	}
	if (running) {
		if !layer_exists("RunningParticle") layer_create(-1000, "RunningParticle")
		var _p = part_system_create(partRunning);
		part_system_layer(_p, "RunningParticle");
		part_system_position(_p, x+hspd, y);
	}
	if (round(hspd) == 0) sprite_index = sprite.idle;

	if (vspd < 0) {
		vspd = min(12, vspd + GRAVITY);
	} else {
		vspd = min(12, vspd + GRAVITY*2);
	}
	
	var _jumpthrough = instance_position(x, y+abs(vspd)+1, oJumpthrough);
	var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
	jump_buffer--;
	if (!grounded) {
		coyote_timing--;
	
		if (kJump) {
			jump_buffer = JUMP_BUFFER;
		}
	
		if (vspd < 0 && kJumpReleased) {
			vspd = max(vspd, vspd/2);
		}
	}

	jump_buffer = clamp(jump_buffer, 0, JUMP_BUFFER);
	coyote_timing = clamp(coyote_timing, 0, COYOTE);

	if (grounded) {
		coyote_timing = COYOTE;
	} else {
		state = player_air;
	}

	if ((coyote_timing > 0 && kJump) or (jump_buffer > 0 && grounded)) {
		vspd = jumpspd;
		audio_play_sound(sndJump, 10, 0);
	}
	#region Horizontal Collision

	var _Hpixel_check = sign(hspd);
	//var _jslope = instance_position(x+hdir*(1+sprite_width/2), y, oSlopeJumpthrough);
	var _list = ds_list_create();
	var _jslope = instance_place_list(x+hdir*spd, y, oSlopeJumpthrough, _list, false);
	var yplus = 0;
	if (_jslope) {
		var yplus = 0;
		for (var i=0; i < _jslope; i++) {
			if (!place_meeting(x, y, _list[| i])) {
				if (sign(_list[| i].image_xscale) != hdir) {
					while (place_meeting(x+hspd, y-yplus, _list[| i]) && yplus <= abs(hspd)) 
						yplus++;
				}
				if !(place_meeting(x+hspd, y-yplus, _list[| i])) {
					y -= yplus;
				}
			}
		}
	}
	ds_list_destroy(_list);
	if (place_meeting(x+hspd, y, oBlock)) {
		var yplus = 0;
		while (place_meeting(x+hspd, y-yplus, oBlock) && yplus <= abs(hspd)) yplus++;

		if (hspd <> 0 && place_meeting(x+hspd, y-yplus, oBlock) && !place_meeting(x, y, oBlock)) {
			while !(place_meeting(x+_Hpixel_check, y, oBlock)) {
				x += _Hpixel_check;
			}
			hspd = 0;
		} else {
			y -= yplus;
		}
	}
	x += hspd;
	#endregion

	#region Vertical Collision
	// Descer da rampa
	if (grounded) && (place_meeting(x, y+abs(hspd)+1, [oBlock, oJumpthrough])) && (vspd >= 0) {
		vspd += abs(hspd) + 1;
	}
	
	
	if (vspd <> 0 && place_meeting(x, y+vspd, oBlock)) 
	|| (_jumpthrough != noone && vspd >= 0 && place_meeting(x, y+abs(vspd), _jumpthrough) && !place_meeting(x, y, _jumpthrough)) {
		y = round(y);
		while !(place_meeting(x, y+sign(vspd), [oBlock, _jumpthrough])) y+=sign(vspd);
		vspd = 0;
	}
	y += vspd;
	#endregion
}

function player_air() {
	get_inputs();
	move = kRight - kLeft;
	spd = minspd*(!kRun) + maxspd*kRun;

	if (move != 0) {	
		dir = move;
		hspd += move*(acc_a);
	} else {
		hspd = approach(hspd, 0, fric_a);
	}
	hspd = clamp(hspd, -spd, spd);
	if (running) sprite_index = sprite.runjump;
	if (vspd < 0) {
		if (!running) sprite_index = sprite.jump;
		vspd = min(12, vspd + GRAVITY);
	} else {
		if (!running) sprite_index = sprite.fall;
		vspd = min(12, vspd + GRAVITY*2);
	}
	var _jumpthrough = instance_position(x, y+abs(vspd)+1, oJumpthrough);
	var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
	jump_buffer--;
	if (!grounded) {
		coyote_timing--;
	
		if (kJump) {
			jump_buffer = JUMP_BUFFER;
		}
		if (vspd < 0 && kJumpReleased) {
			vspd = max(vspd, vspd/2);
		}
		
	}

	jump_buffer = clamp(jump_buffer, 0, JUMP_BUFFER);
	coyote_timing = clamp(coyote_timing, 0, COYOTE);

	if (grounded) {
		coyote_timing = COYOTE;
		state = player_ground;
		sprite_index = sprite.idle;
	}

	if ((coyote_timing > 0 && kJump) or (jump_buffer > 0 && grounded)) {
		vspd = jumpspd;
		audio_play_sound(sndJump, 10, 0);
	}
	#region Horizontal Collision

	var _Hpixel_check = sign(hspd);
	var _list = ds_list_create();
	var _jslope = instance_place_list(x+hdir*spd, y, oSlopeJumpthrough, _list, false);
	
	if (_jslope) {
		var yplus = 0;
		for (var i=0; i < _jslope; i++) {
			if (!place_meeting(x, y, _list[| i])) {
				if (sign(_list[| i].image_xscale) != hdir) {
					while (place_meeting(x+hspd, y-yplus, _list[| i]) && yplus <= abs(hspd)) 
						yplus++;
				}
				if !(place_meeting(x+hspd, y-yplus, _list[| i])) {
					y -= yplus;
				}
			}
		}
	}
	ds_list_destroy(_list);
	if (place_meeting(x+hspd, y, oBlock)) {
		var yplus = 0;
		while (place_meeting(x+hspd, y-yplus, oBlock) && yplus <= abs(hspd)) yplus++;

		if (hspd <> 0 && place_meeting(x+hspd, y-yplus, oBlock) && !place_meeting(x, y, oBlock)) {
			
			while !(place_meeting(x+_Hpixel_check, y, oBlock)) {
				x += _Hpixel_check;
			}
			hspd = 0;
		} else {
			y -= yplus;
		}
	}
	x += hspd;
	#endregion

	#region Vertical Collision
	// Descer da rampa
	if (grounded) && (place_meeting(x, y+abs(hspd)+1, [oBlock, oJumpthrough])) && (vspd >= 0) {
		vspd += abs(hspd) + 1;
	}
	
	
	if (vspd <> 0 && place_meeting(x, y+vspd, oBlock)) 
	|| (_jumpthrough != noone && vspd >= 0 && place_meeting(x, y+abs(vspd), _jumpthrough) && !place_meeting(x, y, _jumpthrough)) {
		y = round(y);
		while !(place_meeting(x, y+sign(vspd), [oBlock, _jumpthrough]))  {
			y+=sign(vspd);
		}
		vspd = 0;
	}
	y += vspd;
	#endregion
}

function player_climb() {
	return;
}

function player_water() {
	return;
}

function player_death() {
	vspd += GRAVITY;
	sprite_index = sprite.death;
	audio_stop_sound(mOverworld);
	with (oCamera) {
		target = noone;
	}
	if (!audio_is_playing(sndDeath)) {
		room_restart();
	}
	y += vspd;
}
#endregion

#region Power-Ups

function shoot_fireball() {
	if (kSpecial) {
		if instance_number(oFireball) < 2 {
			audio_play_sound(sndShoot, 10, 0);
			with(instance_create_depth(x+hspd, y-sprite_height/2, depth-1, oFireball)) {
				dir = other.dir;
				vspd = -1;
			}
		}
	}
}

function shoot_hammer() {
	
}

#endregion