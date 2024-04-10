if (!surface_exists(global.view_surf)) {
	global.view_surf = surface_create(game_width + 1, game_height + 1);
}

view_surface_id[0] = global.view_surf;

var cam = view_camera[0];
var camX = x-game_width*zoom*0.5;
var camY = y-game_height*zoom*0.5;
/*
if instance_exists(target) {
	var camX = x-game_width*zoom*0.5;
	var camY = y-game_height*zoom*0.5;
} else {
	var camX = 0;
	var camY = 0;
}
*/
//camX = clamp(camX, 0, room_width-(game_width*zoom));
//camY = clamp(camY, 0, room_height-(game_height*zoom));

camera_set_view_pos(
	cam, 
	floor(camX), 
	floor(camY)
);

if (surface_get_width(global.view_surf) != game_width*zoom + 1) {
	camera_set_view_size(cam, game_width*zoom + 1, game_height*zoom + 1);
	display_set_gui_size(game_width*zoom, game_height*zoom);
	surface_resize(global.view_surf, game_width*zoom + 1, game_height*zoom + 1);
}