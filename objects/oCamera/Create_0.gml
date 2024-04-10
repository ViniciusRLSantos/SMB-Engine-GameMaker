application_surface_enable(false);

//visible = debug_mode;
res_width = display_get_width();
res_height = display_get_height();

game_width = RESOLUTION_W;
game_height = RESOLUTION_H;
scale = 3;

//window_set_fullscreen(true);
window_set_size(game_width*scale, game_height*scale);
window_center();
surface_resize(application_surface, res_width, res_height);
display_set_gui_size(game_width, game_height);

camera_set_view_size(view_camera[0], game_width + 1, game_height + 1);
zoom = 1;
zoom_to = 1;
global.view_surf = -1;
xTo = x;
yTo = y;

filter = 0;

target = oPlayer;