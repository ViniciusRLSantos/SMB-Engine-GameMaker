hspd = 0;
vspd = 0;

activated = false;
move = false;

points = [];
if (path_exists(path)) {
	var _path_length = path_get_number(path);
	for (var i=0; i<_path_length; i++) {
		var xx = path_get_point_x(path, i);
		var yy = path_get_point_y(path, i);
		var _coord = [xstart+xx, ystart+yy];
		array_push(points, _coord);
	}
}


dir = -1;
current = 0;
target = 0;
if (array_length(points) > 1) {
	target = 1;
}

for (var i=16*length-1; i>=0; i--) {
	recorded_positions[i] = [x, y];
	recorded_direction[i] = dir;
}
with(instance_create_depth(x, y, depth-2, oSnakeEnd)) {
	owner = other;
	step = 16*other.length - 1;
}