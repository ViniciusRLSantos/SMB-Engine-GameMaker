
gpu_set_blendenable(false);
var cam = view_camera[0];
var ax = camera_get_view_x(cam) - x + game_width*zoom/2;
var ay = camera_get_view_y(cam) - y + game_height*zoom/2;

var _guiW = window_get_width();
var _guiH = window_get_height();

var _surfW = surface_get_width(global.view_surf);
var _surfH = surface_get_height(global.view_surf);

if (surface_exists(global.view_surf)) {
	
	switch(filter) {
		case 0:
			draw_surface_part(global.view_surf, -frac(ax), -frac(ay), game_width*zoom, game_height*zoom, 0, 0);
			//draw_surface(global.view_surf, -frac(ax), -frac(ay));
		break;
		
		case 1:
			var _texture = surface_get_texture(global.view_surf);
	        var _texelW = texture_get_texel_width(_texture);
	        var _texelH = texture_get_texel_height(_texture);
        
	        shader_set(shdCaseyMuratori);
	        gpu_set_tex_filter(true);
	        shader_set_uniform_f(shader_get_uniform(shdCaseyMuratori, "u_vTexelSize"), _texelW, _texelH);
	        shader_set_uniform_f(shader_get_uniform(shdCaseyMuratori, "u_vScale"), _guiW/_surfW, _guiH/_surfH);

			draw_surface_part(global.view_surf, -frac(ax), -frac(ay), game_width*zoom, game_height*zoom, 0, 0);
			
			shader_reset();
	        gpu_set_tex_filter(false);
		break;
	}
	//draw_surface_part(view_surf, -frac(ax), -frac(ay), game_width*zoom, game_height*zoom, 0, 0);
	//draw_surface(view_surf, -frac(ax), -frac(ay));
}
gpu_set_blendenable(true);
/*
if (debug_mode) {
	//outline_begin();
	draw_text(16, 16, $"Filter: {bool(filter)}");
	//outline_end();
}