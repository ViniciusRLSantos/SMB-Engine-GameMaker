
hspd = dir * spd * moving;
vspd = min(12, vspd + GRAVITY);
image_speed = moving;

// Collision with player
if (instance_exists(oPlayer)) {
	
	if (sign(self.x - oPlayer.x) != 0) stomp_dir = sign(self.x - oPlayer.x);
	
	if (oPlayer.y < self.y - sprite_height/2) {
		if ( oPlayer.vspd >= 0 && place_meeting(x, y-oPlayer.vspd, oPlayer) ) {
			with(oPlayer) {
				if (kJumpHeld) vspd = jumpspd; else vspd = jumpspd/3;
				other.dir = other.stomp_dir;
			}
			moving = !moving;
		}
	} else {
		if (moving && sign(hspd)==sign(oPlayer.x - x)) {
			if (place_meeting(x+hspd, y, oPlayer)) {
				kill_player();
			}
		}
	}
	with (oPlayer) {
		if (hspd <> 0) {
			if (place_meeting(x+hspd, y, other) && !other.moving) {
				other.dir = sign(other.x - x);
				other.moving = true;
			}
		}
	}
}

// Solid Collisions
var _grounded = place_meeting(x, y+1, [oBlock, oJumpthrough]) && !place_meeting(x, y, [oBlock, oJumpthrough]);
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
if (_grounded) && (place_meeting(x, y+abs(hspd)+1, oBlock)) && (vspd >= 0) {
	vspd += abs(hspd) + 1;
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