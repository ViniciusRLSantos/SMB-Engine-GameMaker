var gridx = (x-8) div CELL_SIZE;
var gridy = (y-8) div CELL_SIZE;

if !ds_exists(global.map, ds_type_grid) exit;

if !(moving) {
	hspd = 0;
	vspd = 0;
	if (keyboard_check_pressed(vk_anykey)) {
		switch (keyboard_key) {
			case vk_right:
				if (global.map[# gridx+1, gridy] == 1) {
					x+=spd+1;
					hspd = spd;
					audio_play_sound(sndMapMove, 10, 0);
					moving = true;
				}
			break;
		
			case vk_left:
				if (global.map[# gridx-1, gridy] == 1) {
					x-=spd+1;
					hspd = -spd;
					audio_play_sound(sndMapMove, 10, 0);
					moving = true;
				}
			break;
		
			case vk_down:
				if (global.map[# gridx, gridy+1] == 1) {
					y+=spd+1;
					vspd = spd;
					audio_play_sound(sndMapMove, 10, 0);
					moving = true;
				}
			break;
		
			case vk_up:
				if (global.map[# gridx, gridy-1] == 1) {
					y-=spd+1;
					vspd = -spd;
					audio_play_sound(sndMapMove, 10, 0);
					moving = true;
				}
			break;
		}
	}
	var _level = instance_place(x, y, oLevelSelect);
	if (_level != noone) {
		if (keyboard_check_pressed(ord("Z")) && !world_select) {
			if (room_exists(_level.level)) {
				//room_goto(_level.level);
				world_select = true;
				audio_play_sound(sndLevelSelect, 10, 0);
				//tfx_room_goto(_level.level);
				//if !(layer_exists("Transition")) layer_create(-500, "Transition");
				with(oTransition) {
					target_room = _level.level;
					transition = true;
				}
				
			}
			else
				show_debug_message("Essa fase não existe")
		}
	}
	
} else {
	x+=hspd;
	y+=vspd;
	if (global.map[# gridx, gridy] == 2) {
		if (point_distance(x-8, y-8, gridx*CELL_SIZE+8, gridy*CELL_SIZE+8) <= spd) {
			x = (gridx+1)*CELL_SIZE;
			y = (gridy+1)*CELL_SIZE;
			moving = false;
		}
	}
}
