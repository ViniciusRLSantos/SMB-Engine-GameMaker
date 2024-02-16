
get_inputs();
#region Main Logic
script_execute(state);
if (sign(hspd) != 0) hdir = sign(hspd);
#endregion

#region Power-Ups
if (state != player_death) {
	switch(powerUp) {
		case POWER.MARIOMUSH:
			sprite = BigSkin;
			mask_index = sprite.collision_mask;
			hp = 2;
			block_strength = 2;
		break;
		case POWER.MARIOFIRE:
			sprite = FireSkin;
			mask_index = sprite.collision_mask;
			hp = 3;
			block_strength = 2;
			shoot_fireball();
		break;
		case POWER.MARIOLEAF:
			sprite = BigSkin;
			mask_index = sprite.collision_mask;
			hp = 3;
			block_strength = 2;
		break;
		case POWER.MARIOHAMMER:
			sprite = HammerSkin;
			mask_index = sprite.collision_mask;
			hp = 3;
			block_strength = 2;
			shoot_hammer();
		break;
		default:
			sprite = MiniSkin;
			mask_index = sprite.collision_mask;
			hp = 1;
			block_strength = 0;
		break;
	}
} else {
	mask_index = -1;
}
#endregion

#region Death
if (y > room_height + 8) {
	if state != player_death {
		vspd = jumpspd;
		audio_stop_all();
		audio_play_sound(sndDeath, 10, 0);
		state = player_death;
	}
	
}
#endregion