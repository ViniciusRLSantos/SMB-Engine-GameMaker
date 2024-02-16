dir = owner.recorded_direction[step];
if (owner.move && dir != -1) {
	
	//x = recorded_positions[step][0];
	//y = recorded_positions[step][1];
	hspd = owner.recorded_positions[step-1][0] - owner.recorded_positions[step][0];
	vspd = owner.recorded_positions[step-1][1] - owner.recorded_positions[step][1];
	
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if ((place_meeting(x-other.hspd, y, other)) && !place_meeting(x, y, other)) {
				x += other.hspd;
			}
			
			if (place_meeting(x, y-1, other) && !place_meeting(x, y, other)) {
				vspd = 0;
			}
			
			if (place_meeting(x, y+abs(other.vspd), other) && !place_meeting(x, y, other)) {
				y+=other.vspd;
			}
		}
	}
	
	x+=hspd;
	y+=vspd;
	
}