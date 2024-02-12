
get_inputs();
script_execute(state);

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
	break;
	case POWER.MARIOLEAF:
		sprite = BigSkin;
		mask_index = sprite.collision_mask;
		hp = 3;
		block_strength = 2;
	break;
	case POWER.MARIOHAMMER:
		sprite = BigSkin;
		mask_index = sprite.collision_mask;
		hp = 3;
		block_strength = 2;
	break;
	default:
		sprite = MiniSkin;
		mask_index = sprite.collision_mask;
		hp = 1;
		block_strength = 0;
	break;
}