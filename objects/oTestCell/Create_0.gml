global.map = ds_grid_create(room_width div CELL_SIZE, room_height div CELL_SIZE);

var _width = ds_grid_width(global.map), _height = ds_grid_height(global.map);

var lay_id = layer_get_id("PathDefinition");
var map_id = layer_tilemap_get_id(lay_id);

for (var i=0; i < _width; i++) {
	for (var j=0; j<_height; j++) {
		var xx = i * CELL_SIZE;
		var yy = j * CELL_SIZE;
		var _x = tilemap_get_cell_x_at_pixel(map_id, xx, yy);
		var _y = tilemap_get_cell_y_at_pixel(map_id, xx, yy);
		var tiledata = tilemap_get(map_id, _x, _y);
		global.map[# i, j] = tiledata;
	}
}

debug = debug_mode;

font_enable_effects(fntMap, true, {
    outlineEnable: true,
    outlineDistance: 1,
    outlineColour: c_blue
});
