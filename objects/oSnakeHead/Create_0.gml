hspd = 0;
vspd = 0;

activated = false;
move = false;

points = [];
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