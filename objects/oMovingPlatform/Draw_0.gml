var _len = array_length(points);
switch(mode) {
	case FreeMoveLoop:
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
	break;
	default:
		for (var i=0; i<_len-1; i++) {
			var p1 = i % _len;
			var p2 = (i+1) % _len;
	
			draw_line(
				points[p1][0],
				points[p1][1],
				points[p2][0],
				points[p2][1]
			);
		}
	break;
}

if (debug_mode) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text(x, y-sprite_height, script_get_name(mode));
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
draw_self();