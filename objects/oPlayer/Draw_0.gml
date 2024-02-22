if (state != player_death) {
	switch(carry) {
		case CARRY.GREENSHELL:
			draw_sprite_ext(sGreenKoopaShell, 0, x+dir*sprite_width/2, y-sprite_height/10, dir, 1, 0, c_white, 1);
		break;
		case CARRY.REDSHELL:
			draw_sprite_ext(sRedKoopaShell, 0, x+dir*sprite_width/2, y-sprite_height/10, dir, 1, 0, c_white, 1);
		break;
	}
	draw_sprite_ext(sprite_index, image_index, x, y, dir, 1, 0, noone, 1);
} else {
	draw_sprite_ext(sprite.death, 0, x, y, dir, 1, 0, noone, 1);
}

if (hit && state != player_death) {
	shader_set(shdColorSwap);
	var c = shader_get_uniform(shdColorSwap, "color");
	var a = shader_get_uniform(shdColorSwap, "alpha");

	shader_set_uniform_f(c, 1.0, 1.0, 1.0);
	shader_set_uniform_f(a, wave(0.3, 1.0, 0.1));
	draw_sprite_ext(sprite_index, image_index, x, y, dir, 1, 0, noone, 1);
	shader_reset();
}

/*
draw_text(16, 16, $"x: {x}\ny: {y}");
draw_text(128, 16, $"hspd: {hspd}\nvspd: {vspd}");