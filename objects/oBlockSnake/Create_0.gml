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

for (var i=16*length/spd-1; i>=0; i--) {
	recorded_positions[i] = [x, y];
	recorded_direction[i] = dir;
}
//show_debug_message($"record_length: {array_length(recorded_positions)}\nLength: {length}")
for (var i=1; i<length; i++) {
	with(instance_create_depth(x, y, depth-i, oBlockSnakeBody)) {
		owner = other.object_index;
		step = i*16/other.spd;
	}
}
