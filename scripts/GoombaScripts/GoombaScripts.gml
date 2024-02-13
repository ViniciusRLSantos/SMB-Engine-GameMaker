function GoombaWalk(){
	hspd = spd * dir * in_view_x(48);
	vspd = min(12, vspd + GRAVITY);
	sprite_index = sprite.walk;
	var _grounded = place_meeting(x, y+1, [oBlock, oJumpthrough]) && !place_meeting(x, y, [oBlock, oJumpthrough]);

	// Collision with player
	if (instance_exists(oPlayer)) {
		if (place_meeting(x, y-1, oPlayer)) {
			if (oPlayer.state != player_death && oPlayer.vspd > 0 && oPlayer.y < self.y - sprite_height/2) {
				spd = 0;
				hspd = 0;
				with(oPlayer) {
					if (kJumpHeld) vspd = jumpspd; else vspd = jumpspd/3;
				}
				//audio_play_sound(, 10, 0);
				alarm[0] = room_speed*1.2;
				state = GoombaStomped;
			}
		} 
		if place_meeting(x, y, oPlayer) {
			kill_player();
		}
	}
	if (place_meeting(x+sign(hspd), y, par_entity)) dir*=-1;
	
	// Solid Collisions
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
	if (collision_line(x-1-sprite_width/2, y+1, x+1+sprite_width/2, y+1, oSlope, false, false)) {
		if (_grounded) && (place_meeting(x, y+abs(hspd)+1, oBlock)) && (vspd >= 0) {
		    vspd += abs(hspd) + 1;
		}
	} else if !position_meeting(x+1+sprite_width*dir/2, y+1, [oBlock, oJumpthrough]) {
		dir *= -1;
	}
	#endregion
    
	#region Vertical Collision with Solids and One Way platformer
	repeat(ceil(abs(vspd))) {
	    if (vspd <> 0 && place_meeting(x, y+sign(vspd), oBlock))
	    || (vspd >= 0 && !place_meeting(x, y, oJumpthrough) && place_meeting(x, y+sign(vspd), oJumpthrough)) {
	        vspd = 0;
	        break;
	    } else {
	        y+=sign(vspd);
	    }
	}
	#endregion
	
}

function GoombaKnocked() {
	vspd += GRAVITY;
	sprite_index = sprite.knocked;
	if (!in_view_y(-32)) instance_destroy();
}

function GoombaStomped() {
	sprite_index = sprite.death;
}