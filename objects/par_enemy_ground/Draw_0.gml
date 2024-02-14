draw_sprite_ext(sprite_index, image_index, x, y, dir, 1, 0, c_white, 1);

// Debugging
if debug_mode {
	draw_circle(x+dir*(2+spd+sprite_width/2), y-sprite_height/2, 1, false);
}
