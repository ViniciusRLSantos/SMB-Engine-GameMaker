/*
game_width = RESOLUTION_W;
game_height = RESOLUTION_H;
*/

//visible = debug_mode;

res_width = display_get_width();
res_height = display_get_height();
scale = 3;
surf_scale = 2;

window_set_size(RESOLUTION_W * scale, RESOLUTION_H * scale);
surface_resize(application_surface, res_width, res_height);
camera_set_view_size(view_camera[0], RESOLUTION_W, RESOLUTION_H);
display_set_gui_size(RESOLUTION_W, RESOLUTION_H);

window_center();
xTo = x;
yTo = y;

target = oPlayer;
