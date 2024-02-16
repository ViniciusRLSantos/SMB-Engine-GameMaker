function EnemyWalk(){
	hspd = spd * dir * in_view_x(48);
	vspd = min(16, vspd + GRAVITY);
	sprite_index = sprite.walk;
	
	
	var _list = ds_list_create();

	var _jumpthrough = collision_rectangle(bbox_left, y+abs(vspd)+1,bbox_right, y-1, oJumpthrough, true, true);
	var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
	
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
					state = stomp_state;
				}
			} 
		} else {
			if place_meeting(x, y, oPlayer) {
				kill_player();
			}
		}
		
		
	}
	#endregion
	
	#region Collision with Entity
	// Collision with Entity
	var _entity = collision_line(x+dir*(2+spd+sprite_width/2), y-sprite_height-2, x+dir*(2+spd+sprite_width/2), y+2, par_entity, true, true);
	if (_entity != noone && !place_meeting(x, y, par_entity)) {
		dir*=-1;
	}
	#endregion

	// Solid Collision
	#region Horizontal Collision
	repeat(ceil(abs(hspd))) {
	    var yplus = 0;
	    if (place_meeting(x+sign(hspd), y-yplus, oBlock) && yplus <= abs(hspd)) yplus++;
    
	    if (place_meeting(x+sign(hspd), y-yplus, oBlock)) {
	        dir *= -1;
	        break;
	    } else {
	        x+=sign(hspd);
	        y-=yplus;
	    }
	}
	#endregion
    
	#region Snap to slope when on ground
	switch (can_fall) {
		case true:
			if (grounded) && (place_meeting(x, y+abs(hspd)+1, [oBlock, _jumpthrough])) && (vspd >= 0) {
				vspd += abs(hspd) + 1;
			}
		break;
		case false:
			if (collision_rectangle(x-1-sprite_width/2, y-1, x+1+sprite_width/2, y+1, oSlope, false, false)) ||
			(_jumpthrough != noone && _jumpthrough.image_angle <> 0 && collision_rectangle(x-1-sprite_width/2, y-1, x+1+sprite_width/2, y+1, _jumpthrough, false, false)){
				if (grounded) && (place_meeting(x, y+abs(hspd)+1, oBlock)) && (vspd >= 0) {
				    vspd += abs(hspd) + 1;
				}
			} else if !position_meeting(x+1+sprite_width*dir/2, y+1, [oBlock, oJumpthrough]) {
				dir *= -1;
			}
		break;
	}
	#endregion
    
	#region Vertical Collision with Solids and One Way platformer
	repeat(ceil(abs(vspd))) {
	    if (vspd <> 0 && place_meeting(x, y+sign(vspd), oBlock))
	    || (vspd >= 0 && !place_meeting(x, y, _jumpthrough) && place_meeting(x, y+sign(vspd), _jumpthrough)) {
	        vspd = 0;
	        break;
	    } else {
	        y+=sign(vspd);
	    }
	}
	#endregion
	
}

function EnemyKnocked() {
	vspd += GRAVITY;
	sprite_index = sprite.knocked;
	if (!in_view_y(32)) instance_destroy();
	y+=vspd;
}

function EnemyStomped() {
	despawn_time--;
	if (despawn_time <= 0) instance_destroy();
	sprite_index = sprite.death;
}

function SwapToShell() {
	with (instance_create_depth(x, y, depth-1, oShell)) {
		sprite_index = other.shell_sprite;
	}
	instance_destroy();
}