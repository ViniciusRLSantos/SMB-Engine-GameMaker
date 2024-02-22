if (place_meeting(x, y, oPlayer)) {
	switch(enter_side) {
		case SIDE.RIGHT:
			if (keyboard_check(vk_right)) {
				with(instance_create_depth(x, y, depth, oMarioPipe, {side: enter_side, current_powerup: oPlayer.powerUp})) {
					entering = true;
					current_powerup = oPlayer.powerUp;
					side = other.enter_side;
					room_to = other.room_target;
				}
				instance_destroy(oPlayer);
			}
		break;
		
		case SIDE.LEFT:
			if (keyboard_check(vk_left)) {
				with(instance_create_depth(x, y, depth, oMarioPipe, {side: enter_side, current_powerup: oPlayer.powerUp})) {
					entering = true;
					current_powerup = oPlayer.powerUp;
					side = other.enter_side;
					room_to = other.room_target;
				}
				instance_destroy(oPlayer);
			}
		break;
		
		case SIDE.DOWN:
			if (keyboard_check(vk_down)) {
				with(instance_create_depth(x, y, depth, oMarioPipe, {side: enter_side, current_powerup: oPlayer.powerUp})) {
					entering = true;
					current_powerup = oPlayer.powerUp;
					side = other.enter_side;
					room_to = other.room_target;
				}
				instance_destroy(oPlayer);
			}
		break;
		
		case SIDE.UP:
			if (keyboard_check(vk_up)) {
				with(instance_create_depth(x, y, depth, oMarioPipe, {side: enter_side, current_powerup: oPlayer.powerUp})) {
					entering = true;
					current_powerup = oPlayer.powerUp;
					side = other.enter_side;
					room_to = other.room_target;
				}
				instance_destroy(oPlayer);
			}
		break;
	}
}