
hspd = dir * spd * moving;
image_speed = moving;

// Collision with player

with (oPlayer) {
	if (hspd <> 0) {
		if (place_meeting(x+hspd, y, other) && !other.moving) {
			other.dir = sign(other.x - x);
			other.moving = true;
		}
	}
}

if (instance_exists(oPlayer)) {
	if (place_meeting(x, y-1, oPlayer)) {
		if ( oPlayer.vspd > 0 && oPlayer.y < self.y - sprite_height/2) {
			with(oPlayer) {
				if (kJumpHeld) vspd = jumpspd; else vspd = jumpspd/3;
				if sign(x - other.x) != 0 other.dir = sign(other.x - x);
			}
			moving = !moving;
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