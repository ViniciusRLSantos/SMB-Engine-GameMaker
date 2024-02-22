var x_offset = 2 + (sprite_index == mini.sideways);
draw_sprite_part_ext(
	sprite_index, 
	0,
	left, top,
	width, height,
	x-(x_offset + sprite_width/2)*dir, y-sprite_height,
	dir,
	1,
	c_white,
	1
);

