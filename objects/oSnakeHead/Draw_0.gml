if (debug_mode) {
	draw_set_color(c_white);
	var _len = array_length(points);
	for (var i=0; i<_len-1; i++) {
		var p1 = i;
		var p2 = (i+1);
	
		draw_line(
			points[p1][0],
			points[p1][1],
			points[p2][0],
			points[p2][1]
		);
	}
	draw_set_color(c_white);
}
draw_self();