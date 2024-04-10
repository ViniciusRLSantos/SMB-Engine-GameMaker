if (instance_exists(target)) {
	
	var mx = window_view_mouse_get_x(0);
	var my = window_view_mouse_get_y(0);
	var _limit = 100;
	var _length = min(_limit, point_distance(target.x, target.y-target.sprite_height/2, mx, my)/2);
	var _angle = point_direction(target.x, target.y-target.sprite_height/2, mx, my)
	xTo = target.x;// + lengthdir_x(_length, _angle);
	yTo = (target.y-target.sprite_height/2);// + lengthdir_y(_length, _angle);
}
if (!fixed_x) x += (xTo - x)/4;
if (!fixed_y) y += (yTo - y)/4;
x = clamp(x, game_width*zoom/2, room_width-game_width*zoom/2);
y = clamp(y, game_height*zoom/2, room_height-game_height*zoom/2);

//if (keyboard_check_pressed(ord("F"))) filter = (filter+1) mod 2

zoom = lerp(zoom, zoom_to, 0.2);
zoom_to += 0.25*(mouse_wheel_up() - mouse_wheel_down())
zoom_to = clamp(zoom_to, 0.25, 4)
