application_surface_enable(false);


game_width = 320;
game_height = 180;
scale = 4;

//window_set_fullscreen(true);
window_set_size(game_width*scale, game_height*scale);
window_center();
surface_resize(application_surface, game_width, game_height);
display_set_gui_size(game_width, game_height);

camera_set_view_size(view_camera[0], game_width + 1, game_height + 1);
zoom = 1;
zoom_to = 1;
view_surf = -1;
xTo = 0;
yTo = 0;

target = oPlayer;

