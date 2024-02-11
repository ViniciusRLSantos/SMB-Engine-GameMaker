if (!surface_exists(view_surf)) {
	view_surf = surface_create(game_width + 1, game_height + 1);
}

view_surface_id[0] = view_surf;

if (target == noone) {
	if instance_exists(oPlayer) target = oPlayer;
}

var xTo = target.x;
var yTo = target.y-target.sprite_height/2;

x = xTo;
y = yTo;

var cam = view_camera[0];



var camX = x-game_width*zoom*0.5;
var camY = y-game_height*zoom*0.5;
camX = clamp(camX, 0, room_width-(game_width*zoom));
camY = clamp(camY, 0, room_height-(game_height*zoom));

camera_set_view_pos(
	cam, 
	floor(camX), 
	floor(camY)
);
camera_set_view_size(cam, game_width*zoom + 1, game_height*zoom + 1);
if (surface_get_width(view_surf) != game_width*zoom + 1) {
	surface_resize(view_surf, game_width*zoom + 1, game_height*zoom + 1);
}
