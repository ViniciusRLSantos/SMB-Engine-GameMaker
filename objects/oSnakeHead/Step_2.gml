if (move) {
	if (!collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, oSnakeMiddle, true, true)) {
		instance_create_depth(x, y, depth+1, oSnakeMiddle);
	}
}

if instance_exists(oPlayer) {
	with (oPlayer) {
		if (place_meeting(x, y-1, other) && !place_meeting(x, y, other)) {
			y += other.vspd+1;
		}
	}
}