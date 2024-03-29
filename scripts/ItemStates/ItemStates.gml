function ItemFromBlock() {
	if (spawning) {
		draw_height = approach(draw_height, sprite_get_height(sItemIcon), 0.5);
		y = approach(y, ystart-16, 0.5);
		if (draw_height >= sprite_get_height(sItemIcon)) {
			spawning = false;
		}
	} else {
		draw_height = sprite_get_height(sItemIcon);
		mask_index = sItemIcon;
	
		if (type == ITEM.MUSHROOM || type == ITEM.ONEUP) {
			vspd = min(16, vspd + GRAVITY);
			hspd = dir*spd;
		
			#region JumpThrough Slopes Collision
			if (sign(hspd) != 0) hdir = sign(hspd);
		
			var _list = ds_list_create();

			var _jumpthrough = collision_rectangle(bbox_left, bbox_bottom+abs(vspd)+1,bbox_right, bbox_bottom-1, oJumpthrough, true, true);
			var grounded = place_meeting(x, y+1, oBlock) || (place_meeting(x, y+1, _jumpthrough) && !place_meeting(x, y, _jumpthrough));
	
			var _jumpthrough_list = collision_rectangle_list(bbox_left-abs(hspd), bbox_bottom+abs(vspd)+1,bbox_right+abs(hspd*2), bbox_bottom-2, oJumpthrough, true, true, _list, false);
			if (_jumpthrough_list) {
				for(var i=0; i<_jumpthrough_list; i++) {
					if (_list[| i].image_angle <> 0) {
						var yplus = 0;
						while place_meeting(x+hspd, y-yplus, _list[| i]) && yplus <= abs(hspd) yplus++;
						if (hspd <> 0 && !place_meeting(x+hspd, y-yplus, _list[| i])) {
							y-=yplus;
						}
					}
				}
		
			}
			ds_list_clear(_list);
			ds_list_destroy(_list);

			#endregion
		
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

			if (grounded) && (place_meeting(x, y+abs(hspd)+1, [oBlock, _jumpthrough])) && (vspd >= 0) {
				vspd += abs(hspd) + 1;
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
	}
	ItemCollideWithPlayer()
}


function ItemFromFrame() {
	mask_index = sItemIcon;
	image_alpha = wave(0.2, 1.0, 0.5);
	vspd = 1;
	y+=vspd;
	ItemCollideWithPlayer();
}


function ItemCollideWithPlayer() {
	
	if (instance_exists(oPlayer)) {
		if (place_meeting(x, y, oPlayer) && oPlayer.state != player_death) {
			
			switch (type) {
				case 0:
					with (oPlayer) {
						if (hp == 1) {
							powerUp = POWER.MARIOMUSH;
							audio_play_sound(sndPowerUp, 10, 0);
						} else if (state != ItemFromFrame){
							global.hold_item = POWER.MARIOMUSH;
							audio_play_sound(sndHoldItem, 10, 0);
						}
						
					}
					
				break;
				case 1:
					with (oPlayer) {
						if (hp > 1) global.hold_item = powerUp;
						powerUp = POWER.MARIOFIRE;
					}
					audio_play_sound(sndPowerUp, 10, 0);
				break;
				case 2:
					with (oPlayer) {
						if (hp > 1) global.hold_item = powerUp;
						powerUp = POWER.MARIOLEAF;
					}
					audio_play_sound(sndPowerUp, 10, 0);
				break;
				case 3:
					with (oPlayer) {
						if (hp > 1) global.hold_item = powerUp;
						powerUp = POWER.MARIOHAMMER;
					}
					audio_play_sound(sndPowerUp, 10, 0);
				break;
				case ITEM.ONEUP:
					audio_play_sound(sndOneUp, 10, 0);
				break;
			}
			instance_destroy();
		}
	}
}