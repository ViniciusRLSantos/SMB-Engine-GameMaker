function KoopaWalk() {
	hspd = spd * dir * in_view_x(48);
	vspd = min(12, vspd + GRAVITY);
	
	var _grounded = place_meeting(x, y+1, [oBlock, oJumpthrough]) && !place_meeting(x, y, [oBlock, oJumpthrough]);

	// Collision
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
	
}

function KoopaShell() {
	
}

function KoopaKnocked() {
	
}