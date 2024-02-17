script_execute(mode);
/*
if (freeMove) {
	var _target_point = target % array_length(points);
	var _current_point = current % array_length(points);
	
	var _dist_x = points[_target_point][0] - x;
	var _dist_y = points[_target_point][1] - y;
	dir = arctan2(_dist_y, _dist_x);
	hspd = cos(dir)*spd;
	vspd = sin(dir)*spd;
	
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if (place_meeting(x, y+abs(other.vspd)+1, other) && !place_meeting(x, y, other)) {
				hspd_add = other.hspd;
				y += other.vspd;
				
			}
			
			if ((place_meeting(x-other.hspd, y, other) || place_meeting(x, y+abs(other.vspd)+1, other)) && !place_meeting(x, y, other)) {
				x += other.hspd;
			}		
			
		}
	}
	
	if point_distance(x, y, points[_target_point][0], points[_target_point][1]) > spd {
		x += hspd;
		y += vspd;
	} else {
		x = points[_target_point][0];
		y = points[_target_point][1];
		target++;
	}
}

