if (move) {
	
	if (in_view_x() && in_view_y()) {
		if !(audio_is_playing(sndEngine)) audio_play_sound(sndEngine, 10, 0, 0.5, 0, 1.1);
	}
	var _len = array_length(points);
	var _target_point = target % _len;
	
	var _dist_x = points[_target_point][0] - x;
	var _dist_y = points[_target_point][1] - y;
	dir = arctan2(_dist_y, _dist_x);
	hspd = cos(dir)*spd;
	vspd = sin(dir)*spd;
	
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if ((place_meeting(x-other.hspd, y, other)) && !place_meeting(x, y, other)) {
				x += other.hspd;
			}
			
			if (place_meeting(x, y-1, other) && !place_meeting(x, y, other)) {
				y += other.vspd+1;
			}
			
			if (place_meeting(x, y+abs(other.vspd), other) && !place_meeting(x, y, other)) {
				y+=other.vspd;
			}
			
		}
	}
	
	if point_distance(x, y, points[_target_point][0], points[_target_point][1]) > spd {
		x += hspd;
		y += vspd;
		
		var _len = 16*length/spd - 1;
		for (var i=_len; i>0; i--) {
			recorded_positions[i] = recorded_positions[i-1];
			recorded_direction[i] = recorded_direction[i-1];
		}
		recorded_positions[0] = [x, y];
		recorded_direction[0] = dir;
	} else {
		x = points[_target_point][0];
		y = points[_target_point][1];
		current++;
		target++;
		
		var _len = 16*length/spd - 1;
		for (var i=_len; i>0; i--) {
			recorded_positions[i] = recorded_positions[i-1];
			recorded_direction[i] = recorded_direction[i-1];
		}
		recorded_positions[0] = [x, y];
		recorded_direction[0] = dir;
		
	}
}

if (place_meeting(x, y-1, oPlayer)) {
	if !(activated) {
		activated = true;
		alarm[0] = room_speed;
	}
}
