var _entity = instance_place(x, y, [oPlayer, par_enemy])

if (_entity != noone) {
	
	if place_meeting(x, y, _entity) && owner != _entity  {
		
		with (_entity) {
			var my_par = object_get_parent(object_index);
			var _parEnemy = object_get_parent(par_enemy.object_index);
			
			if instance_id_get(my_par) == instance_id_get(_parEnemy) {
				if state != knocked_state {
					vspd = -3;
					audio_play_sound(sndKnock, 10, 0);
					state = knocked_state;
					if (!other.penetrate) instance_destroy(other);
				}
				
			} else {
				kill_player();
				if (!other.penetrate) instance_destroy(other);
			}
		}
		
	}
}

if (!in_view_x(16) || !in_view_y(52)) instance_destroy();