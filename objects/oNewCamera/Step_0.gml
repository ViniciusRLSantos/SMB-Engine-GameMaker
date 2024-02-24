if (instance_exists(target)) {
	var xTo = target.x;
	var yTo = target.y-target.sprite_height/2;
	
	x += (xTo - x)/2;
	y += (yTo - y)/2;
}

x = clamp(x, RESOLUTION_W/2, room_width-RESOLUTION_W/2);
y = clamp(y, RESOLUTION_H/2, room_height-RESOLUTION_H/2);

