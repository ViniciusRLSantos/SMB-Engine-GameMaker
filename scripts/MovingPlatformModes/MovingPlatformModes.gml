function FreeMoveLoop() {
	var _target_point = target % array_length(points);
	var _current_point = current % array_length(points);
	
	var _dist_x = points[_target_point][0] - x;
	var _dist_y = points[_target_point][1] - y;
	dir = arctan2(_dist_y, _dist_x);
	hspd = cos(dir)*spd;
	vspd = sin(dir)*spd;
	/*
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if (place_meeting(x, y+abs(other.vspd)+1, other) && !place_meeting(x, y, other)) {
				hspd_add = other.hspd;
				y += other.vspd;
				
			}
			
			if (place_meeting(x-other.hspd, y, other) && !place_meeting(x, y, other)) {
				x += other.hspd*other.is_solid;
			}
		}
	}
	*/
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
	/*
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if (place_meeting(x, y+abs(other.vspd)+1, other) && !place_meeting(x, y, other)) {
				hspd_add = other.hspd;
				//x += other.hspd;
				y += other.vspd;
				
			}
			
			
			if (place_meeting(x-other.hspd, y, other) && !place_meeting(x, y, other)) {
				x += other.hspd*other.is_solid;
			}
			
		}
	}
	*/
	if point_distance(x, y, points[_target_point][0], points[_target_point][1]) > spd {
		x += hspd;
		y += vspd;
	} else {
		x = points[_target_point][0];
		y = points[_target_point][1];
		target++;
		if (target >= array_length(points)) {
			
			//show_debug_message(points);
			points = array_reverse(points);
			target = 0;
			//show_debug_message(points);
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
	/*
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if (place_meeting(x, y+abs(other.vspd)+1, other) && !place_meeting(x, y, other)) {
				hspd_add = other.hspd;
				//x += other.hspd;
				y += other.vspd;
			}
			if (place_meeting(x-other.hspd, y, other) && !place_meeting(x, y, other)) {
				x += other.hspd*other.is_solid;
			}
		}
	}
	*/
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
	/*
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if (place_meeting(x, y+abs(other.vspd)+1, other) && 
				!place_meeting(x, y, other) &&
				!place_meeting(x, y+abs(other.vspd), oBlock)) {
				y += other.vspd;
				
			}
		}
	}
	*/
	if !in_view_y(sprite_height) {
		if (debug_mode) {
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