var _len = array_length(points);
for (var i=0; i<_len; i++) {
	var p1 = i % _len;
	var p2 = (i+1) % _len;
	
	draw_line(
		points[p1][0],
		points[p1][1],
		points[p2][0],
		points[p2][1]
	);
}

draw_self();