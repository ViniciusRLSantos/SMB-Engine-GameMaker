view_surface_id[0] = view_get_surface_id(0);

#region Spawn Held Item
var kSpawnItem = keyboard_check_pressed(vk_shift);
if (kSpawnItem && global.hold_item != noone) {
	var cam = view_camera[0];
	var xx = (camera_get_view_x(cam) + display_get_gui_width()/2),
	yy = (camera_get_view_y(cam)+24);
	show_debug_message(xx);
	audio_play_sound(sndDropItem, 10, 0);
	with(instance_create_depth(xx-8, yy, -1000, oItem)) {
		type = global.hold_item;
		draw_height = 16;
		state = ItemFromFrame;
	}
	global.hold_item = noone;
}
#endregion