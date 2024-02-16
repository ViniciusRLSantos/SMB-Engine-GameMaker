if (debug_mode) {
	draw_set_color(c_aqua);
	var _len = array_length(points);
	for (var i=0; i<_len-1; i++) {
		var p1 = i;
		var p2 = (i+1);
	
		draw_line(
			points[p1][0]+8,
			points[p1][1]+8,
			points[p2][0]+8,
			points[p2][1]+8
		);
	}
	draw_set_color(c_white);
}
draw_self();