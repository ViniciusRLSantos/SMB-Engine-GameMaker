function HammerBroWander() {
	if !(in_view_x(32) && in_view_y(128)) exit;
	
	if (instance_exists(oPlayer)) {
		if (sign(oPlayer.x - self.x) != 0) facing = sign(oPlayer.x - self.x)
	}
	
	hspd = spd * dir;
	vspd = min(16, vspd + GRAVITY);
	var _offset = 12;
	if (dir == 1) {
		if (x > xstart+_offset) dir *= -1;
	} else {
		if (x < xstart-_offset) dir *= -1;
	}
	
	#region Throw timer
	throw_timer--;
	if (throw_timer < 20) {
		if (sprite_index == sprite.walk) {
			var _stored_index = image_index;
			sprite_index = sprite.grab;
			image_index = _stored_index;
		}
		
		if (throw_timer <= 0) {
			audio_play_sound(sndHammerThrow, 10, 0);
			with (instance_create_depth(x, y, depth-1, oHammer)) {
				owner = OWNER.ENEMY;
				spd = random_range(1, 2);
				vspd = -irandom_range(7, 9);
				dir = other.facing;
			}
			if (sprite_index == sprite.grab) {
				var _stored_index = image_index;
				sprite_index = sprite.walk;
				image_index = _stored_index;
			}
			throw_timer = irandom_range(room_speed*3, room_speed*6);
		}
		
	}
	#endregion
	
	#region Jumping timer
	jump_timer--;
	if (jump_timer <= 0) {
		if (jumped) y+=3; else vspd = jumpspd;
		jumped = !jumped;
		jump_timer = irandom_range(room_speed*1.5, room_speed*5);
	}
	#endregion
	
	HammerMoveAndCollide();
}


function HammerMoveAndCollide() {
	
	#region Collision with Player
	// Collision with player
	if (instance_exists(oPlayer)) {
		if (oPlayer.y < self.y - sprite_height/3) {
			if (place_meeting(x, y-1, oPlayer)) {
				if (oPlayer.state != player_death) {
					spd = 0;
					hspd = 0;
					with(oPlayer) {
						if (kJumpHeld) vspd = jumpspd; else vspd = jumpspd/3;
					}
					audio_play_sound(sndKnock, 10, 0);
					vspd = -2;
					state = knocked_state;
				}
			} 
		} else {
			if place_meeting(x, y, oPlayer) {
				kill_player();
			}
		}
		
		
	}
	#endregion

	x+=hspd;
	#region Vertical Collision	
	if (vspd >= 0 && place_meeting(x, y+abs(vspd), oBlock) && !place_meeting(x, y, oBlock)) {
		y = floor(y);
		while !(place_meeting(x, y+sign(vspd), oBlock)) y+=sign(vspd);
		vspd = 0;
	}
	y += vspd;
	#endregion
}