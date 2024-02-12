//partBrick
var _ps = part_system_create(partBrick);
/*
//Emitter
var _ptype1 = part_type_create();
part_type_sprite(_ptype1, sBrick, false, true, false)
part_type_size(_ptype1, 1, 1, 0, 0);
part_type_scale(_ptype1, 0.5, 0.5);
part_type_speed(_ptype1, 2, 5, 0, 0);
part_type_direction(_ptype1, 60, 120, 0, 0);
part_type_gravity(_ptype1, 0.25, 270);
part_type_orientation(_ptype1, 0, 359, 2, 1, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 80, 80);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -4, 4, -4, 4, ps_shape_rectangle, ps_distr_gaussian);
part_emitter_burst(_ps, _pemit1, _ptype1, 4);
*/
part_system_position(_ps, x+sprite_width/2, y+sprite_height/2);


