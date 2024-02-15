var _entity = instance_place(x, y, [oPlayer, par_enemy])

if (_entity != noone) {
	//show_debug_message($"Owner: {owner}\nEntity: {instance_id_get(object_get_parent(_entity.object_index))}\nParent: {instance_id_get(object_get_parent(par_enemy.object_index))}");
	if place_meeting(x, y, _entity) && owner != _entity  {
		
		with (_entity) {
			var my_par = object_get_parent(object_index);
			var _parEnemy = object_get_parent(par_enemy.object_index);
			
			if instance_id_get(my_par) == instance_id_get(_parEnemy) {
				vspd = -3;
				audio_play_sound(sndKnock, 10, 0);
				state = knocked_state;
			} else {
				kill_player();
			}
		}
		if (!penetrate) instance_destroy();
	}
}

if (!in_view_x(16) || !in_view_y(52)) instance_destroy();