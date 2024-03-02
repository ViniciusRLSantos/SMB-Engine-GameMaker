function FreeMoveLoop() {
	var _target_point = target % array_length(points);
	var _current_point = current % array_length(points);
	
	var _dist_x = points[_target_point][0] - x;
	var _dist_y = points[_target_point][1] - y;
	dir = arctan2(_dist_y, _dist_x);
	hspd = cos(dir)*spd;
	vspd = sin(dir)*spd;
	
	if point_distance(x, y, points[_target_point][0], points[_target_point][1]) > spd {
		x += hspd;
		y += vspd;
	} else {
		x = points[_target_point][0];
		y = points[_target_point][1];
		target++;
	}
}

function FreeMoveReturn() {
	var _target_point = target % array_length(points);
	var _current_point = current % array_length(points);
	
	var _dist_x = points[_target_point][0] - x;
	var _dist_y = points[_target_point][1] - y;
	dir = arctan2(_dist_y, _dist_x);
	hspd = cos(dir)*spd;
	vspd = sin(dir)*spd;
	
	if point_distance(x, y, points[_target_point][0], points[_target_point][1]) > spd {
		x += hspd;
		y += vspd;
	} else {
		x = points[_target_point][0];
		y = points[_target_point][1];
		target++;
		if (target >= array_length(points)) {
			
			points = array_reverse(points);
			target = 0;
		}
		
	}
}

function WaitForPlayer() {
	if !(can_move) exit;
	
	var _target_point = target % array_length(points);
	var _current_point = current % array_length(points);
	
	var _dist_x = points[_target_point][0] - x;
	var _dist_y = points[_target_point][1] - y;
	dir = arctan2(_dist_y, _dist_x);
	hspd = cos(dir)*spd;
	vspd = sin(dir)*spd;
	
	if point_distance(x, y, points[_target_point][0], points[_target_point][1]) > spd {
		x += hspd;
		y += vspd;
	} else {
		x = points[_target_point][0];
		y = points[_target_point][1];
		target++;
		if (target >= array_length(points)) {
			target = 0;
			vspd = -2;
			mode = FallDown;
		}
	}
	
}

function FallDown() {
	hspd = 0;
	vspd = min(16, vspd + GRAVITY);
	
	if !in_view_y(sprite_height) {
		if (debug_mode) {
			hspd = 0;
			vspd = 0;
			can_move = false;
			activated = false;
			mode = WaitForPlayer;
			x = xstart;
			y = ystart;
		} else {
			instance_destroy();
		}
	}
	x+=hspd;
	y+=vspd;
}