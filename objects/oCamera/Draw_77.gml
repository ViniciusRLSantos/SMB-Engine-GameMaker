/*
gpu_set_blendenable(false);

var _scale = window_get_width()/(game_width*zoom)
if (surface_exists(view_surf)) {
	//draw_surface_part_ext(view_surf, -frac(x)*_scale, -frac(y)*_scale, game_width, game_height, 0, 0, _scale, _scale, noone, 1);
	
	draw_surface_ext(
		view_surf, 
		-frac(x)*_scale, 
		-frac(y)*_scale,
		_scale,
		_scale,
		0,
		c_white,
		1.0
	);
}

gpu_set_blendenable(true);
