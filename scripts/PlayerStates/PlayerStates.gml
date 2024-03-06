#region General Mario States
function player_ground() {
	get_inputs();
	
	collide_with_moving_solids();
	#region Movement
	move = kRight - kLeft;
	
	if (move != 0) {
		
		if (kRun) {
			spd = approach(spd, 3, P_INCREASE);
		} else {
			spd = approach(spd, 2, P_DECREASE);
		}
		
		dir = move;
		if (move <> sign(hspd)) {
			if (hspd != 0)  {
				if !(audio_is_playing(sndSkid)) audio_play_sound(sndSkid, 10, 0);
				if !layer_exists("SkidParticle") layer_create(-100, "SkidParticle")
				var _p = part_system_create(partSkid);
				part_system_layer(_p, "SkidParticle");
				part_system_position(_p, x, y);
			}
			spd = approach(spd, 2, P_DECREASE_FAST);
		} else {
			if abs(hspd) == maxspd {
				running = true;
			} else {
				running = false;
			}
		}
		hspd = approach(hspd, spd*move, acc_g);
	} else {
		spd = approach(spd, 2, P_DECREASE_FAST);
		hspd = approach(hspd, 0, fric_g);
		running = false;
	}

	if (vspd < 0) {
		vspd = min(TERMINAL_VELOCITY, vspd + GRAVITY);
	} else {
		vspd = min(TERMINAL_VELOCITY, vspd + GRAVITY*2);
	}
	#endregion
	
	ApplyPlayerSprites();
	
	#region Jumping
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
		setGrounded(false);
	}
	#endregion
	
	can_climb();
	
	move_and_slide();
}

function player_air() {
	get_inputs();
	
	collide_with_moving_solids();
	
	#region Movement
	//spd = minspd*(!kRun) + maxspd*kRun;
	move = kRight - kLeft;
	if (move != 0) {	
		dir = move;
		hspd = approach(hspd, spd*move, acc_a);;
	} else {
		hspd = approach(hspd, 0, fric_a);
	}
	if (abs(hspd) < 0.1) spd = approach(spd, minspd, P_DECREASE_ON_WALL)
	
	
	if (vspd < 0) {
		vspd = min(TERMINAL_VELOCITY, vspd + GRAVITY);
	} else {
		vspd = min(TERMINAL_VELOCITY, vspd + GRAVITY*2);
	}
	#endregion
	
	#region Jumping
	//var _jumpthrough = collision_rectangle(bbox_left, y+abs(vspd)+1,bbox_right, y, oJumpthrough, true, true);
	//var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
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

	if (grounded && vspd >= 0) {
		coyote_timing = COYOTE;
		state = player_ground;
		sprite_index = sprite.idle;
	}

	if ((coyote_timing > 0 && kJump) or (jump_buffer > 0 && grounded)) {
		vspd = jumpspd;
		audio_play_sound(sndJump, 10, 0);
		setGrounded(false);
	}
	#endregion
	
	can_climb();
	
	move_and_slide();
	
	ApplyPlayerSprites();
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
	/*with (oCamera) {
		target = noone;
	}*/
	with (oNewCamera) {
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
				owner = OWNER.PLAYER;
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
				owner = OWNER.PLAYER;
				spd = 2+min(abs(hspd), 2);
				dir = other.dir;
				vspd = -7;
			}
		}
	}
}

#endregion


#region Apply Sprites

function ApplyPlayerSprites() {
	get_inputs();
	move = kRight - kLeft;
	if (carry == CARRY.NOTHING) {
		
		//var _jumpthrough = collision_rectangle(bbox_left, y+abs(vspd)+1,bbox_right, y, oJumpthrough, true, true);
		//var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
		
		kick_frames = max(0, kick_frames-1);
		if (kick_frames > 0) {
			sprite_index = sprite.kick;
		}
		
		if (grounded && kick_frames <= 0 && vspd >= 0) {
			if (move != 0) {
				if (move <> sign(hspd) && abs(hspd) > 0.1) {
					sprite_index = sprite.turn;
				} else if (abs(hspd) > 0.1) {
					image_speed = abs(hspd)/minspd;
					
					if (!running) {
						sprite_index = sprite.walk;
					} else {
						if (!audio_is_playing(sndRun))audio_play_sound(sndRun, 10, 0);
						sprite_index = sprite.run;
					}
				} else {
					if (running) running = false;
					sprite_index = sprite.idle;
				}
				//show_debug_message($"hspd: {hspd}")
			} else {
				if (abs(hspd) == 0) sprite_index = sprite.idle;
				else {
					image_speed = abs(hspd)/minspd;
					if !(running) {
						sprite_index = sprite.walk;
					} else {
						if (!audio_is_playing(sndRun))audio_play_sound(sndRun, 10, 0);
						sprite_index = sprite.run;
					}
				}
			}
			
			
		} else if (kick_frames <= 0) {
			if !(running) {
				sprite_index = sprite.jump;
			} else {
				if (!audio_is_playing(sndRun))audio_play_sound(sndRun, 10, 0);
				sprite_index = sprite.runjump;
			}
		}
	} else {
		// var _jumpthrough = collision_rectangle(bbox_left, y+abs(vspd)+1,bbox_right, y, oJumpthrough, true, true);
		// var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
		
		sprite_index = sprite.carry;
		if (grounded && vspd >= 0) {
			if (move != 0) {
				 if (abs(hspd) > 0) image_speed = abs(hspd)/minspd;
			}
			if (abs(hspd) == 0) {
				image_speed = 0;
				image_index = 0;
			}
		} else {
			image_speed = 0;
			image_index = image_number-1;
		}
		if (!kRun) {
			kick_frames = KICK_SPRITE_FRAMES;
			switch(carry) {
				default:
					var _offset = 4;
					with(instance_create_depth(x+dir*(_offset + sprite_width/2), y-sprite_height/5, depth+1, oShell)) {
						type = other.carry;
						dir = other.dir;
						moving = true;
						audio_play_sound(sndKnock, 10, 0);
					}
				break;
			}
			carry = CARRY.NOTHING;
		}
	}
}

#endregion


#region Collision Script

function collide_with_moving_solids() {
	var _rightWall = noone;
	var _leftWall = noone;
	var _bottomWall = noone;
	var _topWall = noone;
	var _list = ds_list_create();
	var _collisions = instance_place_list(x, y, oMovePlatformSolid, _list, false);
	
	for (var i=0; i<_collisions; i++) {
		var _inst = _list[| i];
		
		// Colliding with right side of moving platform
		if _inst.bbox_left - _inst.hspd >= bbox_right-1 {
			if (!instance_exists(_rightWall) || _inst.bbox_left < _rightWall.bbox_left) {
				_rightWall = _inst;
			}
		}
		
		// Colliding with left side of moving platform
		if (_inst.bbox_right - _inst.hspd <= bbox_left+1) {
			if (!instance_exists(_leftWall) || _inst.bbox_right > _leftWall.bbox_right) {
				_leftWall = _inst;
			}
		}
		
		// Colliding with bottom side of moving platform
		if (_inst.bbox_top - _inst.vspd >= bbox_bottom-1) {
			if (!instance_exists(_bottomWall) || _inst.bbox_top < _bottomWall.bbox_top) {
				_bottomWall = _inst;
			}
		}
		
		// Collising with top side of moving platform
		if (_inst.bbox_bottom - _inst.vspd <= bbox_top+1) {
			if (!instance_exists(_topWall) || _inst.bbox_bottom > _topWall.bbox_bottom) {
				_topWall = _inst;
			}
		}
	}
	ds_list_destroy(_list);
	
	// Snap to moving platform
	if (instance_exists(_rightWall)) {
		var _rightDist = bbox_right - x;
		x = _rightWall.bbox_left - _rightDist;
	}
	
	if (instance_exists(_leftWall)) {
		var _leftDist = x - bbox_left;
		x = _leftWall.bbox_right + _leftDist;
	}
	
	if (instance_exists(_bottomWall)) {
		var _bottomDist = bbox_bottom - y;
		y = _bottomWall.bbox_top - _bottomDist;
	}
	
	if (instance_exists(_topWall)) {
		var _upDist = y - bbox_top;
		var _targetY = _topWall.bbox_bottom + _upDist;
		show_debug_message("TOP DETECTED")
		if (!place_meeting(x, _targetY, oBlock)) {
			y = _targetY;
			
		}
	}
	
	// Stick to your platform
	moveEarly = false;
	if (instance_exists(myFloor) && myFloor.hspd != 0 && !place_meeting(x, y+floorMaxVspd+1, myFloor)) {
		if (!place_meeting(x+myFloor.hspd, y, myFloor)) {
			x += myFloor.hspd;
			moveEarly = true;
		}
	}
	
}

function move_and_slide() {
	#region Jumpthrough Slopes
	
	var _list = ds_list_create();
	var _jumpthrough_list = collision_rectangle_list(bbox_left-1, bbox_bottom, bbox_right+1, bbox_bottom+abs(vspd)+1, oJumpthrough, true, true, _list, false);
	for(var i=0; i<_jumpthrough_list; i++) {
		if (_list[| i].image_angle <> 0 && sign(_list[| i].image_angle) == hdir) {
			var yplus = 0;
			while place_meeting(x+(hdir)*spd, y-yplus, _list[| i]) && yplus <= abs(hspd*1) yplus++;
			if (!place_meeting(x+hspd, y-yplus, _list[| i])) {
				y-=yplus;					
			}
		}
	}
	ds_list_destroy(_list);
	#endregion
	
	#region Horizontal Collision
	var hspd_final = hspd + hspd_add;
	hspd_add = 0;
	
	if (place_meeting(x+hspd_final, y, oBlock)) {
		var yplus = 0;
		while (place_meeting(x+hspd_final, y-yplus, oBlock) && yplus <= abs(hspd_final)) yplus++;

		if (hspd_final <> 0 && place_meeting(x+hspd_final, y-yplus, oBlock) && !place_meeting(x, y, oBlock)) {
			while (abs(hspd_final) > 0.1) {
				hspd_final *= 0.5;
				if !place_meeting(x+hspd_final, y, oBlock) x+=hspd_final;
			}
			hspd_final = 0;
			hspd = 0;
		} else {
			y -= yplus;
		}
	}
	
	// Go down slopes
	var _colliders = [oBlock, oJumpthrough];
	var _subpixel = 1;
	downJumpthroughFloor = noone;
	if (grounded && vspd >= 0 && !place_meeting(x+hspd_final, y+1, _colliders) && place_meeting(x+hspd_final, y+abs(hspd_final)+1, _colliders)) {
		downJumpthroughFloor = checkJumpthrough(x+hspd, y+abs(hspd_final)+1);
		if (!instance_exists(downJumpthroughFloor)) {// || (instance_exists(downJumpthroughFloor) && downJumpthroughFloor.image_angle != 0)) {
			while !(place_meeting(x+hspd, y+_subpixel, _colliders)) y+=_subpixel;
		}
	}
	x += hspd_final;
	#endregion
	
	#region Vertical Collision	
	// Upwards Collision
	var _subpixel = 0.5;
	if (vspd < 0 && place_meeting(x, y+vspd, oBlock)) {
		while (abs(vspd) > 0.1) {
			vspd *= 0.5;
			if (!place_meeting(x, y+vspd, oBlock)) y+=vspd;
		}
		vspd = 0;
	}
	
	// Downwards Collision
	var _clamp_vspd = max(0, vspd);
	var _colliders = [oBlock, oJumpthrough];
	var _list = ds_list_create();
	var _collisions = instance_place_list(x, y+1+_clamp_vspd, _colliders, _list, false);
	for (var i=0; i<_collisions; i++) {
		var _inst = _list[| i];
		if (_inst.object_index == oJumpthrough && _inst.image_angle <> 0 && vspd >= 0 && !place_meeting(x, y, _inst)) {
			myFloor = _inst;
		} else if (_inst.vspd <= vspd || instance_exists(myFloor))
		&& (_inst.vspd > 0 || place_meeting(x, y+1+_clamp_vspd, _inst)) {
			// Return Solid or Jumpthrough
			if (_inst.object_index == oBlock
			|| object_is_ancestor(_inst.object_index, oBlock)
			|| floor(bbox_bottom) <= ceil(_inst.bbox_top - _inst.vspd)) {
				if !(instance_exists(myFloor))
				|| _inst.bbox_top + _inst.vspd <= myFloor.bbox_top + myFloor.vspd
				|| _inst.bbox_top + _inst.vspd <= bbox_bottom {
					myFloor = _inst;
				}
			}
		}	
	}
	
	ds_list_destroy(_list);
	
	if (instance_exists(downJumpthroughFloor)) myFloor = downJumpthroughFloor;
	
	// Reset floor variable
	if (instance_exists(myFloor) && !place_meeting(x, y+floorMaxVspd, myFloor)) {
		myFloor = noone;
	}
	
	if (instance_exists(myFloor) && vspd >= 0) {
		if (debug_mode) {
			myFloor.touching = true;
		}
		y = floor(y);
		var _subpixel = 1;
		while (!place_meeting(x, y+_subpixel, myFloor) && !place_meeting(x, y, oBlock)) y+=_subpixel;
		if (myFloor.object_index == oJumpthrough || object_is_ancestor(myFloor.object_index, oJumpthrough)) && (myFloor.image_angle == 0) {
			while (place_meeting(x, y, myFloor)) { 
				y -= _subpixel;
			}
		}
		y = floor(y);
		vspd = 0;
		setGrounded(true);
	}
	y += vspd;
	
	
	if (instance_exists(myFloor)) {
		if (!moveEarly && (myFloor.object_index != oSnakeHead && myFloor.object_index != oSnakeEnd)) hspd_add = myFloor.hspd;
	} else {
		setGrounded(false);
	}
	
	// Snap y-coord to myFloor object
	if (instance_exists(myFloor)) 
	&& (myFloor.vspd != 0 
	|| myFloor.object_index == oMovePlatformSolid
	|| object_is_ancestor(myFloor.object_index, oMovePlatformSolid)
	|| myFloor.object_index == oMovePlatformJumpthrough
	|| object_is_ancestor(myFloor.object_index, oMovePlatformJumpthrough)) {
		// Snap to top of floor
		if (!place_meeting(x, myFloor.bbox_top, oBlock))
		&& (myFloor.bbox_top >= bbox_bottom-floorMaxVspd) {
			y = myFloor.bbox_top + y - bbox_bottom;
		}
	}
	// Push through jumpthrough by moving solid platform
	if (instance_exists(myFloor))
	&& (myFloor.object_index == oJumpthrough || object_is_ancestor(myFloor.object_index, oJumpthrough))
	&& (place_meeting(x, y, oBlock)) {
		var _maxPushDist = 10;
		var _pushDist = 0;
		var _starty = y;
		while (place_meeting(x, y, oBlock) && _pushDist <= _maxPushDist) {
			y++;
			_pushDist++;
		}
		setGrounded(false);
	}
	
	#endregion
}

function can_climb() {
	get_inputs();
	if (place_meeting(x, y, oClimb)) && (kUpPressed||kDownPressed) {
		state = player_climb;
	}
}

#endregion
