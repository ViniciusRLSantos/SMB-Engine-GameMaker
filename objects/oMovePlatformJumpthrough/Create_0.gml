
points = [];
if (path_exists(path)) {
	//array_push(points, [xstart, ystart]);
	var _path_length = path_get_number(path);
	for (var i=0; i<_path_length; i++) {
		var xx = path_get_point_x(path, i);
		var yy = path_get_point_y(path, i);
		var _coord = [xstart+xx, ystart+yy];
		array_push(points, _coord);
	}
}

target = 0;
current = 0;
if (array_length(points) > 1) {
	target = 1;
}

dir = 0;
hspd = 0;
vspd = 0;
is_solid = false;

activated = false;
can_move = false;