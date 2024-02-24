var lay_id = layer_get_id("PathDefinition");
var map_id = layer_tilemap_get_id(lay_id);
var _x = tilemap_get_cell_x_at_pixel(map_id, mouse_x, mouse_y);
var _y = tilemap_get_cell_y_at_pixel(map_id, mouse_x, mouse_y);
var tiledata = tilemap_get(map_id, _x, _y);
/*
show_debug_message(tiledata);