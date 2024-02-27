if (move) {
	if (!collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, oSnakeMiddle, true, true)) {
		instance_create_depth(x, y, depth-1, oSnakeMiddle);
	}
}