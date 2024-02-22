entering = false;
room_to = noone;
current_sprite = noone

mini = new PipeSkin(sMiniMarioPipe, sMiniMarioIdle);
big = new PipeSkin(sBigMarioPipe, sBigMarioIdle);
fire = new PipeSkin(sFireMarioPipe, sFireMarioIdle);
hammer = new PipeSkin(sHammerMarioPipe, sHammerMarioIdle);

switch (current_powerup) {
	case POWER.MARIOMUSH:
		skin = big;
	break;
	
	case POWER.MARIOFIRE:
		skin = fire;
	break;
	
	case POWER.MARIOHAMMER:
		skin = hammer
	break;
	
	default:
		skin = mini;
	break;
}

switch (side) {
	case SIDE.RIGHT:
		sprite_index = skin.sideways;
	break;
		
	case SIDE.LEFT:
		sprite_index = skin.sideways;
	break;
		
	case SIDE.DOWN:
		sprite_index = skin.front;
	break;
		
	case SIDE.UP:
		sprite_index = skin.front;
	break;
}

width = sprite_width;
height = sprite_height;
left = 0;
top = 0;
set_vars = false;

if instance_exists(oPlayer) {
	x = oPlayer.x-8;
	y = oPlayer.y-sprite_height;
}
alarm[0] = room_speed;
