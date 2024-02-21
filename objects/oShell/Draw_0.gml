switch(type) {
	case CARRY.GREENSHELL:
		draw_sprite_ext(sGreenKoopaShell, image_index, x, y, dir, 1, 0, c_white, 1);
	break;
	case CARRY.REDSHELL:
		draw_sprite_ext(sRedKoopaShell, image_index, x, y, dir, 1, 0, c_white, 1);
	break;
}