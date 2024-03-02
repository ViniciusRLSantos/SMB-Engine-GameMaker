function BrickSpawnItem() {
    
    if !(instance_exists(oPlayer)) exit;
    
    #region Colliding with Player
    if (oPlayer.vspd <= 0 && place_meeting(x, y+1, oPlayer) && !place_meeting(x, y, oPlayer)) {
    	if (!bonked) {
    		var _enemy = instance_place(x, y-1, par_enemy);
    		if (_enemy != noone) {
    			with(_enemy) {
    				if state != knocked_state {
    					state = knocked_state;
    					vspd = -2;
    					audio_play_sound(sndKnock, 10, 0);
    						
    				}
    			}
    		}
    		bonked = true;
    		audio_play_sound(sndBump, 10, 0);
    		spawnItem();
    		yy -= offset;
    		sprite_index = sBlockNull;
    	}
    }
    #endregion
    
    #region Colliding with Shell
    if instance_exists(oShell) {
    	with (oShell) {
    		if place_meeting(x+hspd, y, other) && !other.bonked {
    			var _enemy = instance_place(other.x, other.y-1, par_enemy);
    			if (_enemy != noone) {
    				with(_enemy) {
    					if state != knocked_state {
    						state = knocked_state;
    						vspd = -2;
    						audio_play_sound(sndKnock, 10, 0);
    						
    					}
    				}
    			}
    			other.bonked = true;
    			audio_play_sound(sndBump, 10, 0);
    			other.spawnItem();
    			other.yy -= other.offset;
    			other.sprite_index = sBlockNull;
    		}
    	}
    }
    #endregion
    
}


function BrickBreak() {
    
    if !(instance_exists(oPlayer)) exit;
    
    #region Colliding with Player
    if (oPlayer.vspd <= 0 && place_meeting(x, y+1, oPlayer) && !place_meeting(x, y, oPlayer)) {
    	if (oPlayer.block_strength < 2) {
    		if (!bonked) {
    			var _enemy = instance_place(x, y-1, par_enemy);
    			if (_enemy != noone) {
    				with(_enemy) {
    					if state != knocked_state {
    						state = knocked_state;
    						vspd = -2;
    						audio_play_sound(sndKnock, 10, 0);
    						
    					}
    				}
    			}
    			bonked = true;
    			audio_play_sound(sndBump, 10, 0);
    			alarm[0] = 10
    			yy-=offset;			
    		}
    	} else {
    		var _enemy = instance_place(x, y-1, par_enemy);
    		if (_enemy != noone) {
    			with(_enemy) {
    				if state != knocked_state {
    					state = knocked_state;
    					vspd = -2;
    					audio_play_sound(sndKnock, 10, 0);
    						
    				}
    			}
    		}
    		instance_destroy();
    	}
    }
    #endregion
    
    #region Collising with Shell
    if instance_exists(oShell) {
    	with (oShell) {
    		if place_meeting(x+hspd, y, other) && !other.bonked {
    			var _enemy = instance_place(other.x, other.y-1, par_enemy);
    			if (_enemy != noone) {
    				with(_enemy) {
    					if state != knocked_state {
    						state = knocked_state;
    						vspd = -2;
    						audio_play_sound(sndKnock, 10, 0);
    						
    					}
    				}
    			}
    			instance_destroy(other);
    			dir *= -1;
    		}
    	}
    }
    #endregion

}
