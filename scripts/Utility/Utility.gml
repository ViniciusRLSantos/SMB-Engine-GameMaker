function approach(from, to, amount) {
	if (from < to) {
		return min(to, from + amount);
	} else if (from > to) {
		return max(to, from - amount);
	} else {
		return to;
	}
}

function in_view_x(margin=0) {
	var cam = view_camera[0];
	var camX = camera_get_view_x(cam);
	var camW = camera_get_view_width(cam);
	
	return (self.x > camX-margin && self.x<camX+camW+margin )
}

function in_view_y(margin=0) {
	var cam = view_camera[0];
	var camY = camera_get_view_y(cam);
	var camH = camera_get_view_height(cam);
	
	return (self.y > camY-margin && self.y<camY+camH+margin )
}
