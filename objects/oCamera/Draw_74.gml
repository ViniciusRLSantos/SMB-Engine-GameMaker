
gpu_set_blendenable(false);
var cam = view_camera[0];
var ax = camera_get_view_x(cam) - x + game_width*zoom/2;
var ay = camera_get_view_y(cam) - y + game_height*zoom/2;
if (surface_exists(view_surf)) {
	draw_surface_part(view_surf, -frac(ax), -frac(ay), game_width*zoom, game_height*zoom, 0, 0);
	//draw_surface(view_surf, -frac(ax), -frac(ay));
}
gpu_set_blendenable(true);
