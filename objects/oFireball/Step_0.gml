hspd = dir*spd;
vspd += GRAVITY;

var _grounded = place_meeting(x, y+1, [oBlock, oJumpthrough]) && !place_meeting(x, y, [oBlock, oJumpthrough]);


// Solid Collisions

#region Horizontal Collision
repeat(ceil(abs(hspd))) {
	var yplus = 0;
	if (place_meeting(x+sign(hspd), y-yplus, oBlock) && yplus <= abs(hspd)) yplus++;
    
	if (place_meeting(x+sign(hspd), y-yplus, oBlock)) {
		instance_destroy();
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
		vspd = bounce;
		break;
	} else {
		y+=sign(vspd);
	}
}
#endregion