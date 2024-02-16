#region General Mario States
function player_ground() {
	get_inputs();
	#region Movement
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
	
	if (round(hspd) == 0) sprite_index = sprite.idle;

	if (vspd < 0) {
		vspd = min(12, vspd + GRAVITY);
	} else {
		vspd = min(12, vspd + GRAVITY*2);
	}
	#endregion
	
	
	#region Jumping
	var _jumpthrough = collision_rectangle(bbox_left, y+abs(vspd)+1,bbox_right, y, oJumpthrough, true, true);
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
	#endregion
	
	can_climb();
	
	move_and_slide();
	
}

function player_air() {
	get_inputs();
	#region Movement
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
	#endregion
	
	
	#region Jumping
	var _jumpthrough = collision_rectangle(bbox_left, y+abs(vspd)+1,bbox_right, y, oJumpthrough, true, true);
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
	#endregion
	
	can_climb();
	
	move_and_slide();
	
}

function player_climb() {
	get_inputs();
	sprite_index = sprite.climb;
	
	#region Movement
	var xaxis = kRight - kLeft;
	var yaxis = kDown - kUp;
	
	if (xaxis != 0 || yaxis != 0) {
		image_speed = 1;
		var _dir = arctan2(yaxis, xaxis);
		hspd = cos(_dir)*climb_spd;
		vspd = sin(_dir)*climb_spd;
	} else {
		image_speed = 0;
		hspd = 0;
		vspd = 0;
	}
	#endregion
	
	#region Jumping
	if (kJump) {
		vspd = jumpspd;
		state = player_air;
		image_speed = 1;
	}
	#endregion
	
	if !place_meeting(x, y, oClimb) {
		state = player_ground;
		image_speed = 1;
	}
	
	move_and_slide();
	
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
			with(instance_create_depth(x+hspd+dir*sprite_width/2, y-sprite_height/2, depth-1, oFireball)) {
				owner = other.id;
				dir = other.dir;
			}
		}
	}
}

function shoot_hammer() {
	if (kSpecial) {
		if instance_number(oHammer) < 2 {
			audio_play_sound(sndShoot, 10, 0);
			with(instance_create_depth(x+hspd, y-sprite_height/2, depth-1, oHammer)) {
				owner = other.id;
				dir = other.dir;
				vspd = -7;
			}
		}
	}
}

#endregion



#region Collision Script


function move_and_slide() {
	
	var _list = ds_list_create();

	var _jumpthrough = collision_rectangle(bbox_left, y+abs(vspd)+1,bbox_right, y-1, oJumpthrough, true, true);
	var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
	
	#region Horizontal Collision
	var _jumpthrough_list = collision_rectangle_list(bbox_left-abs(hspd), y+abs(vspd)+1,bbox_right+abs(hspd), y-2, oJumpthrough, true, true, _list, false);
	if (_jumpthrough_list) {
		for(var i=0; i<_jumpthrough_list; i++) {
			if (_list[| i].image_angle <> 0) {
				var yplus = 0;
				while place_meeting(x+hdir*spd, y-yplus, _list[| i]) && yplus <= abs(hspd*2) yplus++;
				if (hspd <> 0 && !place_meeting(x+hspd, y-yplus, _list[| i])) {
					y-=yplus;
				}
			}
		}
		
	}
	ds_list_clear(_list);
	ds_list_destroy(_list);
	var hspd_final = hspd + hspd_add;
	var _Hpixel_check = sign(hspd_final);
	hspd_add = 0;
	
	if (place_meeting(x+hspd_final, y, oBlock)) {
		var yplus = 0;
		while (place_meeting(x+hspd_final, y-yplus, oBlock) && yplus <= abs(hspd_final)) yplus++;

		if (hspd_final <> 0 && place_meeting(x+hspd_final, y-yplus, oBlock) && !place_meeting(x, y, oBlock)) {
			while !(place_meeting(x+_Hpixel_check, y, oBlock)) {
				x += _Hpixel_check;
			}
			hspd_final = 0;
			hspd = 0;
		} else {
			y -= yplus;
		}
	}
	x += hspd_final;
	#endregion
	
	
	
	// Descer da rampa
	if (grounded) && (place_meeting(x, y+abs(hspd)+1, [oBlock, _jumpthrough]) && !place_meeting(x, y, [oBlock, _jumpthrough])) && (vspd >= 0) {
		vspd += abs(hspd) + 1;
	}
	
	
	
	#region Vertical Collision	
	if (vspd <> 0 && place_meeting(x, y+vspd, oBlock)) 
	|| (_jumpthrough != noone && vspd >= 0 && place_meeting(x, y+abs(vspd), _jumpthrough) && !place_meeting(x, y, _jumpthrough)) {
		y = round(y);
		while !(place_meeting(x, y+sign(vspd), [oBlock, _jumpthrough])) y+=sign(vspd);
		vspd = 0;
	}
	y += vspd;
	#endregion
}

function can_climb() {
	get_inputs();
	if (place_meeting(x, y, oClimb)) && (kUpPressed||kDownPressed) {
		state = player_climb;
	}
}

#endregion