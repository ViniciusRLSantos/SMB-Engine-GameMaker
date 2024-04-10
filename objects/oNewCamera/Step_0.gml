/*
if (instance_exists(target)) {
	var mx = window_view_mouse_get_x(0);
	var my = window_view_mouse_get_y(0);
	var _limit = 75;
	var _length = min(_limit, point_distance(target.x, target.y-target.sprite_height/2, mx, my)/2);
	var _angle = point_direction(target.x, target.y-target.sprite_height/2, mx, my)
	xTo = target.x + lengthdir_x(_length, _angle);
	yTo = (target.y-target.sprite_height/2) + lengthdir_y(_length, _angle);
	x += (xTo - x)/10;
	y += (yTo - y)/10;
}

x = clamp(x, RESOLUTION_W/2, room_width-RESOLUTION_W/2);
y = clamp(y, RESOLUTION_H/2, room_height-RESOLUTION_H/2);

