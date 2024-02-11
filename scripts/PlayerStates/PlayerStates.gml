#region Mini Mario
function player_ground() {
	get_inputs();
	move = kRight - kLeft;
	spd = minspd*(!kRun) + maxspd*kRun;
	if (move != 0) {	
		dir = move;
		if (move <> sign(hspd)) {
			if (hspd != 0) sprite_index = sprite.turn;
		} else {
			image_speed = abs(hspd)/spd;
			if abs(hspd) == maxspd {
				sprite_index = sprite.run;
				running = true;
			} else {
				sprite_index = sprite.walk;
				
			}
		}
		hspd = approach(hspd, spd*move, acc_g);
	} else {
		hspd = approach(hspd, 0, fric_g);
		if (round(hspd) == 0) sprite_index = sprite.idle;
		running = false;
	}

	if (vspd < 0) {
		vspd = min(12, vspd + GRAVITY);
	} else {
		vspd = min(12, vspd + GRAVITY*2);
	}

	var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, oJumpthrough) && !place_meeting(x, y, oJumpthrough));
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
		show_debug_message(running);
	}

	if ((coyote_timing > 0 && kJump) or (jump_buffer > 0 && grounded)) {
		vspd = jumpspd;
	}
	#region Horizontal Collision

	var _Hpixel_check = sign(hspd);
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
	|| (vspd >= 0 && place_meeting(x, y+abs(vspd), oJumpthrough) && !place_meeting(x, y, oJumpthrough)) {
		y = round(y);
		while !(place_meeting(x, y+sign(vspd), [oBlock, oJumpthrough])) y+=sign(vspd);
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

	var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, oJumpthrough) && !place_meeting(x, y, oJumpthrough));
	jump_buffer--;
	if (!grounded) {
		//sprite_index = sprite.jump
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
	}
	#region Horizontal Collision

	var _Hpixel_check = sign(hspd);
	if place_meeting(x+hspd, y, oBlock) {
		var yplus = 0;
		while (place_meeting(x+hspd, y-yplus, oBlock) && yplus <= abs(hspd)) yplus++;

		if (place_meeting(x+hspd, y-yplus, oBlock)) {
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
	|| (vspd >= 0 && place_meeting(x, y+abs(vspd), oJumpthrough) && !place_meeting(x, y, oJumpthrough)) {
		y = round(y);
		while !(place_meeting(x, y+sign(vspd), [oBlock, oJumpthrough])) y+=sign(vspd);
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
#endregion

