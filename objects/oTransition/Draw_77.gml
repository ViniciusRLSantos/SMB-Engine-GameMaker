if (transition) {
	application_surface_draw_enable(false);
	/*
	if !surface_exists(surf) {
		surf = surface_create(room_width, room_height);
	}
	
	surface_copy(surf, 0, 0, application_surface);
	*/
	//surface_resize(surf, display_get_width(), display_get_height());
	
	if (!switched) {
		amount--;
		if (amount <= 10) {
			amount = 10;
			switched = true;
			room_goto(target_room);
		}
	} else {
		amount++;
		if (amount >= 100) {
			amount = 100;
			transition = false;
			switched = false;
			application_surface_draw_enable(true);
		}
	}
	gpu_set_blendenable(false);
	shader_set(shdPixelate);
	shader_set_uniform_f(pixel_amount, amount);
		draw_surface(application_surface, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));
	shader_reset();
	gpu_set_blendenable(true);
}