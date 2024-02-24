application_surface_enable(false);


game_width = RESOLUTION_W;
game_height = RESOLUTION_H;
scale = 3;

//window_set_fullscreen(true);
window_set_size(game_width*scale, game_height*scale);
window_center();
//surface_resize(application_surface, game_width, game_height);
display_set_gui_size(game_width, game_height);

camera_set_view_size(view_camera[0], game_width + 1, game_height + 1);
zoom = 1;
zoom_to = 1;
global.view_surf = -1;
xTo = 0;
yTo = 0;

filter = 0;

target = oPlayer;