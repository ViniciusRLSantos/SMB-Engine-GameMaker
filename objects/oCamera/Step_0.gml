if (instance_exists(target)) {
	xTo = target.x;
	yTo = target.y-target.sprite_height/2;
}
if (!fixed_x) x += (xTo - x)/10;
if (!fixed_y) y += (yTo - y)/10;
x = clamp(x, game_width*zoom/2, room_width-game_width*zoom/2);
y = clamp(y, game_height*zoom/2, room_height-game_height*zoom/2);