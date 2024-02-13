if (spawning) {
	draw_height = approach(draw_height, sprite_get_height(sItemIcon), 0.75);
	y = approach(y, ystart-16, 0.75);
	if (draw_height >= sprite_get_height(sItemIcon)) {
		spawning = false;
	}
} else {
	draw_height = sprite_get_height(sItemIcon);
	mask_index = sItemIcon;
	
	if (type == ITEM.MUSHROOM || type == ITEM.ONEUP) {
		vspd += GRAVITY;
		hspd = dir/2;
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
	}
}


if (instance_exists(oPlayer)) {
	if (place_meeting(x, y, oPlayer) && oPlayer.state != player_death) {
		audio_play_sound(sndPowerUp, 10, 0);
		switch (type) {
			case ITEM.MUSHROOM:
				with (oPlayer) {
					powerUp = POWER.MARIOMUSH;
				}					
			break;
			case ITEM.FIREFLOWER:
				with (oPlayer) {
					powerUp = POWER.MARIOFIRE;
				}
			break;
			case ITEM.LEAF:
				with (oPlayer) {
					powerUp = POWER.MARIOLEAF;
				}
			break;
			case ITEM.HAMMERSUIT:
				with (oPlayer) {
					powerUp = POWER.MARIOHAMMER;
				}
			break;
			case ITEM.ONEUP:
			break;
		}
		instance_destroy();
	}
}