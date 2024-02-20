var _entity = instance_place(x, y, [oPlayer, par_enemy])

if (_entity != noone) {
	
	if place_meeting(x, y, _entity) {
		if object_is_ancestor(_entity.object_index, par_enemy) {
			with (_entity) {
				if other.owner == OWNER.PLAYER {
					if state != knocked_state {
						vspd = -3;
						audio_play_sound(sndKnock, 10, 0);
						state = knocked_state;
						if (!other.penetrate) instance_destroy(other);
					}
				
				}
			}
		} else {
			with (_entity) {
				if (other.owner == OWNER.ENEMY) {
					kill_player();
					if (!other.penetrate) instance_destroy(other);
				}
			}
			
		}
	}
}

if (!in_view_x(16) || !in_view_y(72)) instance_destroy();