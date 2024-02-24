layer_set_visible("PathDefinition", debug);
if (debug) {
	var _width = ds_grid_width(global.map), _height = ds_grid_height(global.map);
	draw_set_font(fntMap);
	for (var i=0; i < _width; i++) {
		for (var j=0; j<_height; j++) {
			var xx = i * CELL_SIZE;
			var yy = j * CELL_SIZE;
			draw_text_transformed(xx+10, yy+8, global.map[# i, j], 0.5, 0.5, 0);
		}
	}
	draw_set_font(fntGame);
}

