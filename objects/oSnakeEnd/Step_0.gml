// Inherit the parent event
event_inherited();

if (owner.move) {
	
	hspd = owner.recorded_positions[step-1][0] - owner.recorded_positions[step][0];
	vspd = owner.recorded_positions[step-1][1] - owner.recorded_positions[step][1];
	if (hspd != 0 || vspd != 0) dir = darctan2(vspd, hspd);
	var _len = sprite_width/2;
	var _body = instance_position(x-lengthdir_x(_len, -dir), y-lengthdir_y(_len, -dir), oSnakeMiddle);
	if ((hspd != 0 || vspd != 0) && _body != noone) {
        with(_body) {
            instance_destroy();
        }
	}
	if instance_exists(oPlayer) {
		with (oPlayer) {
			if ((place_meeting(x-other.hspd, y, other)) && !place_meeting(x, y, other)) {
				x += other.hspd;
			}
			
			if (place_meeting(x, y-1, other) && !place_meeting(x, y, other)) {
				vspd = 0;
			}
			
			if (place_meeting(x, y+abs(other.vspd), other) && !place_meeting(x, y, other)) {
				y = other.bbox_top + y - bbox_bottom;
			}
		}
	}
	
	x+=hspd;
	y+=vspd;
	
}

