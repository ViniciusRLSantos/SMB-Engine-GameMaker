

if (entering) {
	var rate = 0.5;
	switch (side) {
		case SIDE.RIGHT:
			sprite_index = skin.sideways;
			if !set_vars {
				set_vars = true;
				width = sprite_width;
				height = sprite_height;
			}
			x = approach(x, xstart+width, rate);
			width = approach(width, 0, rate);
		break;
		
		case SIDE.LEFT:
			sprite_index = skin.sideways;
			if !set_vars {
				set_vars = true;
				width = sprite_width;
				height = sprite_height;
			}
			x = approach(x, xstart-width, rate);
			left = approach(left, width, rate);
		break;
		
		case SIDE.DOWN:
			sprite_index = skin.front;
			if !set_vars {
				set_vars = true;
				width = sprite_width;
				height = sprite_height;
			}
			y = approach(y, ystart+height, rate);
			height = approach(height, 0, rate);
		break;
		
		case SIDE.UP:
			sprite_index = skin.front;
			if !set_vars {
				set_vars = true;
				width = sprite_width;
				height = sprite_height;
			}
			y = approach(y, ystart-height, rate);
			top = approach(top, height, rate);
		break;
	}
}