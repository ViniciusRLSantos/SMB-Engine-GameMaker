#define tfx_core_effect_add_property
///@function tfx_core_effect_add_property(effect_name, property_name, property_default_value, property_min, property_max)
///@arg effect_name string
///@arg property_name string
///@arg property_default_value real
///@arg property_min real
///@arg property_max real

var __effect_name = argument[0];
var __new_property_name = argument[1];
var __new_property_default_value = argument[2];
var __new_property_min = argument[3];
var __new_property_max = argument[4];

//Check if transition doesn't exist
if (!ds_map_exists(global.__tfx_transition_effects,__effect_name)) {
	tfx_core_show_error("Effect \"" + string(__effect_name) + "\" does not exist");
	return undefined;
}

var _transition_map = global.__tfx_transition_effects[? __effect_name];
var _transition_properties = _transition_map[? "properties"];

//Check if property already exists
if (ds_map_exists(_transition_properties,__new_property_name)) {
	tfx_core_show_error("Property \"" + string(__new_property_name) + "\" already exists");
	return false;
}

var _new_property = ds_map_create();
_new_property[? "uniform_id"] = shader_get_uniform(_transition_map[? "shader_id"],__new_property_name);
_new_property[? "value"] = __new_property_default_value;
_new_property[? "min"] = __new_property_min;
_new_property[? "max"] = __new_property_max;

ds_map_add_map(_transition_properties,__new_property_name,_new_property);

return true;

#define tfx_core_effect_create
///@function tfx_core_effect_create(effect_name, effect_shader)
///@arg effect_name string
///@arg effect_shader shader_id

var __effect_name = argument[0];
var __shader_id = argument[1];

//Check if effect already exists
if (ds_map_exists(global.__tfx_transition_effects,__effect_name)) {
	tfx_core_show_error("Effect \"" + string(__effect_name) + "\" already exists");
	return false;
}

//Create effect map
var _effect_map = ds_map_create();
_effect_map[? "name"] = __effect_name;

//Add shader ID to map
_effect_map[? "shader_id"] = __shader_id;

//Add shader "to_texture" sampler ID to map
_effect_map[? "shader_to_texture"] = shader_get_sampler_index(__shader_id, "to_texture");
_effect_map[? "shader_resolution"] = shader_get_uniform(__shader_id,"resolution");

//Add transition properties to map
ds_map_add_map(_effect_map,"properties",ds_map_create());

//Add transitions map to global list
ds_map_add_map(global.__tfx_transition_effects,__effect_name,_effect_map);

//All transitions have a progress property/uniform
tfx_core_effect_add_property(__effect_name,"progress",0,0,1);

return true;

#define tfx_core_get_effect_list
///@function tfx_core_get_effect_list()

var _trans = ds_map_find_first(global.__tfx_transition_effects);
var _temp_list = ds_list_create();
for (var _t = 0; _t < ds_map_size(global.__tfx_transition_effects); _t++;) {
   ds_list_add(_temp_list,_trans);
   _trans = ds_map_find_next(global.__tfx_transition_effects, _trans);
}
ds_list_sort(_temp_list,true);
var _return_list = [];
for (var _t = 0; _t < ds_list_size(_temp_list); _t++;) {
	_trans = _temp_list[| _t];
	_return_list[_t] = _trans;
}
ds_list_destroy(_temp_list);

return _return_list;

#define tfx_core_show_error
///@function tfx_core_show_error(message)
///@arg message
///@arg [stack_offset]

var __message = argument[0];
var __stack_offset = (argument_count > 1) ? argument[1] : 0;

var _debug_stack = better_callstack();

var _scr_nm = string_replace(_debug_stack[__stack_offset+1],"script: '","");
_scr_nm = string_copy(_scr_nm,0,string_pos("'",_scr_nm)-1);

var _error_message = "--------------------------------------------------------------------------------------------";
_error_message += "\nERROR in " + _debug_stack[__stack_offset+2];
_error_message += "\n" + _scr_nm + ": " + __message;
_error_message += "\n--------------------------------------------------------------------------------------------";

show_debug_message(_error_message);

#define tfx_draw
///@function tfx_draw()
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

//Check a transition effect is set
if (_transition_player[? "effect"] == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

//Drawing defaults
var _x = 0;
var _y = 0;
var _x_scale = 1;
var _y_scale = 1;
var _a = 1;

return tfx_draw_ext(_x,_y,_x_scale,_y_scale,_a,_transition_player);

#define tfx_draw_ext
///@function tfx_draw_ext(x, y, x_scale, y_scale, alpha)
///@arg x
///@arg y
///@arg x_scale
///@arg y_scale
///@arg alpha
///@arg [transition_player]

var __x = argument[0];	
var __y = argument[1];
var __x_scale = argument[2];	
var __y_scale = argument[3];	
var __a = argument[4];
var _transition_player = (argument_count > 5) ? argument[5] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

//Check a transition effect is set
if (_transition_player[? "effect"] == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

var _render_result = tfx_render(_transition_player);

if (_render_result == -1) {
	return false;	
}
else if (_render_result == undefined) {
	return undefined;	
}
else {	
	//Draw transition render surface
	draw_surface_ext(_render_result,__x,__y,__x_scale,__y_scale,0,draw_get_color(),__a);
	return true;
}

#define tfx_from_draw_end
///@function tfx_from_draw_end([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

surface_reset_target();

_transition_player[? "from_initial_draw_complete"] = true;

return true;

#define tfx_from_draw_start
///@function tfx_from_draw_start([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

//Check surface exists
if (!surface_exists(_transition_player[? "from_surface"])) {
	_transition_player[? "from_surface"] = surface_create(_transition_player[? "width"],_transition_player[? "height"]);
}

//Set target and clear
surface_set_target(_transition_player[? "from_surface"]);
draw_clear_alpha(_transition_player[? "from_background_color"],_transition_player[? "from_background_alpha"]);

draw_set_color(c_white);
draw_set_alpha(1);

return true;

#define tfx_from_set_background
///@function tfx_from_set_background(color, alpha, [transition_player])
///@arg color real
///@arg alpha real
///@arg [transition_player]

var _transition_player = (argument_count > 2) ? argument[2] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

_transition_player[? "from_background_color"] = argument[0];
_transition_player[? "from_background_alpha"] = argument[1];

return true;

#define tfx_from_use_surface
///@function tfx_from_use_surface(surface, stretch, [blend_alpha,transition_player])
///@arg surface
///@arg stretch
///@arg [blend_alpha,transition_player]

var _transition_player = (argument_count > 3) ? argument[3] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var __linked_surface = argument[0];
var __stretch_surface = argument[1];

if (!surface_exists(__linked_surface)) {
	tfx_core_show_error("Given surface does not exist");
	return undefined;
}

_transition_player[? "from_linked_surface"] = __linked_surface;
_transition_player[? "from_linked_surface_stretch"] = __stretch_surface;
_transition_player[? "from_linked_surface_blend_alpha"] = (argument_count > 2) ? argument[2] : false;

return true;

#define tfx_get_effect
///@function tfx_get_effect([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

if (_transition_player[? "effect"] != -1) {
	var _effect = _transition_player[? "effect"];
	return _effect[? "name"];	
}
else {
	return undefined;
}

#define tfx_get_progress
///@function tfx_get_progress([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

return _transition_player[? "progress"];

#define tfx_get_property
///@function tfx_get_property(property_name,[transition_player])
///@arg property_name string
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

var __property_name = argument[0];
var _effect_properties = _transition_player[? "effect_properties"];

//Check if property is valid
if (ds_map_exists(_effect_properties,__property_name)) {
	return _effect_properties[? __property_name];
}
else {
	tfx_core_show_error("Property \"" + string(__property_name) + "\" does not exist");
	return undefined;
}

#define tfx_get_property_list
///@function tfx_get_property_list([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

//Get properties
var _core_properties = _effect[? "properties"];
var _effect_properties = _transition_player[? "effect_properties"];

//Create array
var _property_list = [];

var _temp_prop_list = ds_list_create();

//Set properties / uniforms
var _u = ds_map_find_first(_core_properties);
while (_u != undefined) {
	if (_u != "progress") {
		ds_list_add(_temp_prop_list,_u);
	}
	_u = ds_map_find_next(_core_properties,_u);
}

ds_list_sort(_temp_prop_list,true);

for (var _p = 0; _p < ds_list_size(_temp_prop_list); _p++) {
	_u = ds_list_find_value(_temp_prop_list,_p);
	var _core_property_map = _core_properties[? _u];
	var _property_value = _effect_properties[? _u];
	_property_list[array_length_1d(_property_list)] = [_u, _property_value, _core_property_map[? "min"], _core_property_map[? "max"]];
	//[name, value, min value, max value]
}

//Return list
return _property_list;

#define tfx_get_property_max
///@function tfx_get_property_max(property_name,[transition_player])
///@arg property_name string
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

var __property_name = argument[0];
var _core_properties = _effect[? "properties"];

//Check if property is valid
if (ds_map_exists(_core_properties,__property_name)) {
	var _property = _core_properties[? __property_name];
	return _property[? "max"];
}
else {
	tfx_core_show_error("Property \"" + string(__property_name) + "\" does not exist");
	return undefined;
}

#define tfx_get_property_min
///@function tfx_get_property_min(property_name,[transition_player])
///@arg property_name string
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

var __property_name = argument[0];
var _core_properties = _effect[? "properties"];

//Check if property is valid
if (ds_map_exists(_core_properties,__property_name)) {
	var _property = _core_properties[? __property_name];
	return _property[? "min"];
}
else {
	tfx_core_show_error("Property \"" + string(__property_name) + "\" does not exist");
	return undefined;
}

#define tfx_get_size
///@function tfx_get_size([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

return [_transition_player[? "width"],_transition_player[? "height"]];

#define tfx_init
///@function tfx_init();
///@description Initialise TransFX

gml_pragma("global","tfx_init()");

#region Core Variables

global.__tfx_transition_effects = ds_map_create();
global.__tfx_transition_players = ds_list_create();

global.__tfx_default_transition_player = tfx_transition_player_create();

#endregion

#region Transitions Effects

//Circle
tfx_core_effect_create("circle",shdr_tfx_circle);
tfx_core_effect_add_property("circle","smoothness",0.1,0,1);

//Wipe
tfx_core_effect_create("wipe",shdr_tfx_wipe);
tfx_core_effect_add_property("wipe","direction",135,0,360);
tfx_core_effect_add_property("wipe","smoothness",0.1,0,1);

//Radial Wipe
tfx_core_effect_create("radial_wipe",shdr_tfx_radial_wipe);
tfx_core_effect_add_property("radial_wipe","starting_angle",90,0,360);
tfx_core_effect_add_property("radial_wipe","wipe_direction",1,-1,1);
tfx_core_effect_add_property("radial_wipe","smoothness",0.1,0,1);

//Blinds
tfx_core_effect_create("blinds",shdr_tfx_blinds);
tfx_core_effect_add_property("blinds","count",10,1,20);
tfx_core_effect_add_property("blinds","direction",320,0,360);
tfx_core_effect_add_property("blinds","smoothness",0.5,0,1);

//Slide In
tfx_core_effect_create("slide",shdr_tfx_slide);
tfx_core_effect_add_property("slide","direction",0,0,360);

//Fade
tfx_core_effect_create("fade",shdr_tfx_fade);

//Fade Blur
tfx_core_effect_create("fade_blur",shdr_tfx_fade_blur);
tfx_core_effect_add_property("fade_blur","blur_size",30,0,100);

//Fade Wave
tfx_core_effect_create("fade_wave",shdr_tfx_fade_wave);
tfx_core_effect_add_property("fade_wave","frequency",10,1,100);
tfx_core_effect_add_property("fade_wave","amplitude",0.1,0,1);

//Fade Ripple
tfx_core_effect_create("fade_ripple",shdr_tfx_fade_ripple);
tfx_core_effect_add_property("fade_ripple","amplitude",5,1,50);
tfx_core_effect_add_property("fade_ripple","frequency",25,1,200);
tfx_core_effect_add_property("fade_ripple","speed",18,1,50);

//Random Squares
tfx_core_effect_create("random_squares",shdr_tfx_random_squares);
tfx_core_effect_add_property("random_squares","grid_width",32,1,640);
tfx_core_effect_add_property("random_squares","grid_height",18,1,360);
tfx_core_effect_add_property("random_squares","smoothness",0.1,0,1);

//Pixelize
tfx_core_effect_create("pixelize",shdr_tfx_pixelize);
tfx_core_effect_add_property("pixelize","max_size",64,1,512);
tfx_core_effect_add_property("pixelize","steps",16,1,128);

#endregion

#define tfx_play
///@function tfx_play([hide_on_finish, play_direction, transition_player])
///@arg [hide_on_finish,play_direction,transition_player]

var _hide_on_finish = (argument_count > 0) ? bool(argument[0]) : 1;
var _play_direction = ((argument_count > 1) && (argument[1] != 0)) ? sign(argument[1]) : 1;
var _transition_player = (argument_count > 2) ? argument[2] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

if (_transition_player[? "automated_transitioning"]) {
	tfx_core_show_error("Unable to start a new transition while one is in progress");
	return false;
}

_transition_player[? "automated_transitioning"] = true;
_transition_player[? "automated_direction"] = _play_direction;
_transition_player[? "automated_start_time"] = current_time;
_transition_player[? "show_transition"] = true;
_transition_player[? "automated_hide_on_finish"] = _hide_on_finish;

tfx_set_progress((_play_direction == 1) ? 0 : 1,_transition_player);

return true;

#define tfx_render
///@function tfx_render([transition_player])
///@arg [transition_player]

var _previous_blendmode = gpu_get_blendmode_ext_sepalpha();
var _previous_alpha = draw_get_alpha();
var _previous_color = draw_get_color();

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}
else if (_transition_player[? "auto_size"]) {
	_transition_player[? "width"] = display_get_gui_width();
	_transition_player[? "height"] = display_get_gui_height();
}

//Check render surface exists
if (!surface_exists(_transition_player[? "render_surface"])) {
	_transition_player[? "render_surface"] = surface_create(_transition_player[? "width"],_transition_player[? "height"]);
}

//Check a transition effect is set
if (_transition_player[? "effect"] == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

if (!_transition_player[? "show_transition"]) {
	return -1;	
}

var _effect = _transition_player[? "effect"];

//Check Room transition
if (_transition_player[? "room_transitioning"]) {
	tfx_to_use_surface(application_surface,true,false,_transition_player);
	
	//Set transition progress
	var _progress = clamp((current_time - _transition_player[? "automated_start_time"]) / _transition_player[? "automated_duration"],0,1);
	tfx_set_progress(_progress,_transition_player);
		
	if (tfx_get_progress(_transition_player) == 1) {
		//Reset transition status
		tfx_set_progress(0,_transition_player);
		_transition_player[? "room_transitioning"] = false;
		_transition_player[? "room_transition_from"] = -1;
		_transition_player[? "room_transition_to"] = -1;
		_transition_player[? "show_transition"] = false;
		_transition_player[? "automated_transitioning"] = false;
		return -1;	
	}
		
	_transition_player[? "from_initial_draw_complete"] = true;
}
//Check Automated transition
else if (_transition_player[? "automated_transitioning"]) {
	
	//Set transition progress
	var _progress = clamp((current_time - _transition_player[? "automated_start_time"]) / _transition_player[? "automated_duration"],0,1);
	if (_transition_player[? "automated_direction"] == -1) {
		_progress = 1 - _progress; //reverse
	}
	tfx_set_progress(_progress,_transition_player);
		
	if (tfx_get_progress(_transition_player) == ((_transition_player[? "automated_direction"] == 1) ? 1 : 0)) {
		_transition_player[? "automated_transitioning"] = false;
		if (_transition_player[? "automated_hide_on_finish"]) {
			//Reset transition status
			tfx_set_progress(0,_transition_player);
			_transition_player[? "show_transition"] = false;
			return -1;
		}
	}
}

var _from_linked_surface = _transition_player[? "from_linked_surface"];
var _to_linked_surface = _transition_player[? "to_linked_surface"];

//Check for "from" linked surface
if ((_from_linked_surface != -1) and surface_exists(_from_linked_surface)) {
	tfx_from_draw_start(_transition_player);
	var _from_surface = _transition_player[? "from_surface"];
	gpu_set_blendenable(false);
	if (_transition_player[? "from_linked_surface_stretch"]) {
		if (!_transition_player[? "from_linked_surface_blend_alpha"]) {
			gpu_set_colorwriteenable(0,0,0,1);
			draw_clear_alpha(c_black,1);
			gpu_set_colorwriteenable(1,1,1,0);
		}
		draw_surface_stretched_ext(_from_linked_surface,0,0,surface_get_width(_from_surface),surface_get_height(_from_surface),c_white,1);	
	}
	else {
		var _scale = min(surface_get_width(_from_surface)/surface_get_width(_from_linked_surface),surface_get_height(_from_surface)/surface_get_height(_from_linked_surface));
		var _x_offset = surface_get_width(_from_surface)-(_scale*surface_get_width(_from_linked_surface));
		var _y_offset = surface_get_height(_from_surface)-(_scale*surface_get_height(_from_linked_surface));
		if (!_transition_player[? "from_linked_surface_blend_alpha"]) {
			gpu_set_colorwriteenable(0,0,0,1);
			draw_set_color(c_black);
			draw_set_alpha(1);
			draw_rectangle(_x_offset/2,_y_offset/2,surface_get_width(_from_surface)*_scale,surface_get_height(_from_surface)*_scale,false);
			draw_set_color(c_white);
			gpu_set_colorwriteenable(1,1,1,0);
		}
		draw_surface_ext(_from_linked_surface,_x_offset/2,_y_offset/2,_scale,_scale,0,c_white,1);
	}	
	gpu_set_blendenable(true);
	tfx_from_draw_end(_transition_player);
}
//Check if nothing has been drawn - fill with background colour
else if (!_transition_player[? "from_initial_draw_complete"]) {
	tfx_from_draw_start(_transition_player);
	tfx_from_draw_end(_transition_player);
}

//Check for "to" linked surface
if ((_to_linked_surface != -1) and surface_exists(_to_linked_surface)) {
	tfx_to_draw_start(_transition_player);
	var _to_surface = _transition_player[? "to_surface"];
	gpu_set_blendenable(false);
	if (_transition_player[? "to_linked_surface_stretch"]) {
		if (!_transition_player[? "to_linked_surface_blend_alpha"]) {
			gpu_set_colorwriteenable(0,0,0,1);
			draw_clear_alpha(c_black,1);
			gpu_set_colorwriteenable(1,1,1,0);
		}
		draw_surface_stretched_ext(_to_linked_surface,0,0,surface_get_width(_to_surface),surface_get_height(_to_surface),c_white,1);	
	}
	else {
		var _scale = min(surface_get_width(_to_surface)/surface_get_width(_to_linked_surface),surface_get_height(_to_surface)/surface_get_height(_to_linked_surface));
		var _x_offset = surface_get_width(_to_surface)-(_scale*surface_get_width(_to_linked_surface));
		var _y_offset = surface_get_height(_to_surface)-(_scale*surface_get_height(_to_linked_surface));
		if (!_transition_player[? "to_linked_surface_blend_alpha"]) {
			gpu_set_colorwriteenable(0,0,0,1);
			draw_set_color(c_black);
			draw_set_alpha(1);
			draw_rectangle(_x_offset/2,_y_offset/2,surface_get_width(_to_surface)*_scale,surface_get_height(_to_surface)*_scale,false);
			draw_set_color(c_white);
			gpu_set_colorwriteenable(1,1,1,0);
		}
		draw_surface_ext(_to_linked_surface,_x_offset/2,_y_offset/2,_scale,_scale,0,c_white,1);
	}
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	gpu_set_colorwriteenable(1,1,1,1);
	tfx_to_draw_end(_transition_player);
}
//Check if nothing has been drawn - fill with background colour
else if (!_transition_player[? "to_initial_draw_complete"]) {
	tfx_to_draw_start(_transition_player);
	tfx_to_draw_end(_transition_player);
}

//Set target and clear
surface_set_target(_transition_player[? "render_surface"]);
draw_clear_alpha(c_black,0);
gpu_set_blendenable(false);

//Set transition effect shader
shader_set(_effect[? "shader_id"]);

//Set "to" texture
texture_set_stage(_effect[? "shader_to_texture"],surface_get_texture(_transition_player[? "to_surface"]));

//Set resolution
shader_set_uniform_f(_effect[? "shader_resolution"],_transition_player[? "width"],_transition_player[? "height"]);

//Get properties
var _core_properties = _effect[? "properties"];
var _effect_properties = _transition_player[? "effect_properties"];

//Set properties / uniforms
var _u = ds_map_find_first(_core_properties);
while (_u != undefined) {
	var _u_map = _core_properties[? _u];
	if (_u == "progress") {
		shader_set_uniform_f(_u_map[? "uniform_id"],_transition_player[? "progress"]);
	}
	else {
		shader_set_uniform_f(_u_map[? "uniform_id"],_effect_properties[? _u]);
	}
	_u = ds_map_find_next(_core_properties, _u);
}

//Draw transition from surface
draw_surface(_transition_player[? "from_surface"],0,0);

shader_reset();
gpu_set_blendenable(true);
if (_transition_player[? "show_debug"]) {
	draw_set_color(c_black);
	draw_set_alpha(0.8);
	draw_rectangle(0,0,_transition_player[? "width"],100,false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	var _scale = 90/_transition_player[? "height"];
	draw_surface_ext(_transition_player[? "from_surface"],5,5,_scale,_scale,0,c_white,1);
	draw_surface_ext(_transition_player[? "to_surface"],_transition_player[? "width"]*_scale+10,5,_scale,_scale,0,c_white,1);
	var _prev_font = draw_get_font();
	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(10,5,"FROM");
	draw_text(_transition_player[? "width"]*_scale+15,5,"TO");
	draw_text(_transition_player[? "width"]*_scale*2+20,5,"TFX PLAYER ID: " + (_transition_player == global.__tfx_default_transition_player ? "DEFAULT" : string(_transition_player)) + "\n\nPROGRESS: " + string_format(_transition_player[? "progress"],1,2) + "\nEFFECT:   " + ds_map_find_value(_transition_player[? "effect"],"name"));
	draw_set_font(_prev_font);
}
surface_reset_target();

//Apply previous drawing settings
gpu_set_blendmode_ext_sepalpha(_previous_blendmode[0],_previous_blendmode[1],_previous_blendmode[2],_previous_blendmode[3]);
draw_set_alpha(_previous_alpha);
draw_set_color(_previous_color);

//Reset settings
_transition_player[? "from_linked_surface"] = -1;
_transition_player[? "from_linked_surface_blend_alpha"] = false;
_transition_player[? "to_linked_surface"] = -1;
_transition_player[? "to_linked_surface_blend_alpha"] = false;
_transition_player[? "from_initial_draw_complete"] = false;
_transition_player[? "to_initial_draw_complete"] = false;

return _transition_player[? "render_surface"];

#define tfx_room_goto
///@function tfx_room_goto(room,[transition_player])
///@arg room
///@arg [transition_player]
var __room = argument[0];
var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

if (_transition_player[? "room_transitioning"]) {
	tfx_core_show_error("Unable to start a new transition while one is in progress");
	return false;
}

if (!room_exists(__room)) { 
	tfx_core_show_error("Room \"" + string(__room) + "\" does not exist");
	return undefined;
}

//Capture application surface
tfx_from_draw_start(_transition_player);
draw_clear_alpha(c_black,1);
gpu_set_colorwriteenable(1,1,1,0);
gpu_set_blendenable(false);
draw_surface_stretched_ext(application_surface,0,0,surface_get_width(_transition_player[? "from_surface"]),surface_get_height(_transition_player[? "from_surface"]),c_white,1);	
gpu_set_blendenable(true);
gpu_set_colorwriteenable(1,1,1,1);
tfx_from_draw_end(_transition_player);

_transition_player[? "room_transitioning"] = true;
_transition_player[? "room_transition_from"] = __room;
_transition_player[? "room_transition_to"] = argument[0];
_transition_player[? "show_transition"] = true;
_transition_player[? "automated_transitioning"] = true;
_transition_player[? "automated_start_time"] = current_time;

tfx_set_progress(0,_transition_player);

room_goto(__room);
return true;

#define tfx_room_goto_next
///@function tfx_room_goto_next([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

return tfx_room_goto(room_next(room), _transition_player);

#define tfx_room_goto_previous
///@function tfx_room_goto_previous([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

return tfx_room_goto(room_previous(room), _transition_player);

#define tfx_set_auto_size
///@function tfx_set_auto_size(enable,[transition_player])
///@arg enable boolean
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

_transition_player[? "auto_size"] = argument[0];

return true;

#define tfx_set_duration
///@function tfx_set_duration(duration,[transition_player])
///@arg duration - milliseconds
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

_transition_player[? "automated_duration"] = argument[0];

return true;

#define tfx_set_effect
///@function tfx_set_effect(effect_name,[transition_player])
///@arg effect_name string
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var __effect_name = argument[0];

if (ds_map_exists(global.__tfx_transition_effects,__effect_name)) {
	var _effect = global.__tfx_transition_effects[? __effect_name];
	
	_transition_player[? "effect"] = _effect;
	
	ds_map_clear(_transition_player[? "effect_properties"]);
	
	//Get properties
	var _properties = _effect[? "properties"];

	//Add effect properties to player
	var _u = ds_map_find_first(_properties);
	while (_u != undefined) {
		if (_u != "progress") {
			var _property = _properties[? _u];
			ds_map_add(_transition_player[? "effect_properties"],_u,_property[? "value"]);
		}
		_u = ds_map_find_next(_properties,_u);
	}
	
	return true;
}
else {
	tfx_core_show_error("Effect \"" + string(__effect_name) + "\" does not exist");
	return undefined;
}

#define tfx_set_progress
///@function tfx_set_progress(progress,[transition_player])
///@arg progress
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

_transition_player[? "progress"] = clamp(argument[0],0,1);
_transition_player[? "show_transition"] = true;

return true;

#define tfx_set_property
///@function tfx_set_property(property_name,property_value,[transition_player])
///@arg property_name string
///@arg property_value real
///@arg [transition_player]

var _transition_player = (argument_count > 2) ? argument[2] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

var __property_name = argument[0];
var __property_value = argument[1];

var _core_properties = _effect[? "properties"];
var _effect_properties = _transition_player[? "effect_properties"];

//Check if property is valid
if (ds_map_exists(_core_properties,__property_name)) {
	var _core_property_map = _core_properties[? __property_name];
	_effect_properties[? __property_name] = clamp(__property_value,_core_property_map[? "min"],_core_property_map[? "max"]);
	return true;
}
else {
	tfx_core_show_error("Property \"" + string(__property_name) + "\" does not exist");
	return undefined;
}

#define tfx_set_property_force
///@function tfx_set_property_force(property_name,property_value,[transition_player])
///@arg property_name string
///@arg property_value real
///@arg [transition_player]

var _transition_player = (argument_count > 2) ? argument[2] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var _effect = _transition_player[? "effect"];

if (_effect == -1) {
	tfx_core_show_error("No transition effect set: Use tfx_set_effect() to set the effect first");
	return undefined;
}

var __property_name = argument[0];
var __property_value = argument[1];

var _core_properties = _effect[? "properties"];
var _effect_properties = _transition_player[? "effect_properties"];

//Check if property is valid
if (ds_map_exists(_core_properties,__property_name)) {
	_effect_properties[? __property_name] = __property_value;
	return true;
}
else {
	tfx_core_show_error("Property \"" + string(__property_name) + "\" does not exist");
	return undefined;
}

#define tfx_set_size
///@function tfx_set_size(width, height, [transition_player])
///@arg width real
///@arg height real
///@arg [transition_player]

var _transition_player = (argument_count > 2) ? argument[2] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

_transition_player[? "width"] = argument[0];
_transition_player[? "height"] = argument[1];

return true;

#define tfx_to_draw_end
///@function tfx_to_draw_end([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

surface_reset_target();

_transition_player[? "to_initial_draw_complete"] = true;

return true;

#define tfx_to_draw_start
///@function tfx_to_draw_start([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

//Check surface exists
if (!surface_exists(_transition_player[? "to_surface"])) {
	_transition_player[? "to_surface"] = surface_create(_transition_player[? "width"],_transition_player[? "height"]);
}

//Set target and clear
surface_set_target(_transition_player[? "to_surface"]);
draw_clear_alpha(_transition_player[? "to_background_color"],_transition_player[? "to_background_alpha"]);

draw_set_color(c_white);
draw_set_alpha(1);

return true;

#define tfx_to_set_background
///@function tfx_to_set_background(color,alpha,[transition_player])
///@arg color real
///@arg alpha real
///@arg [transition_player]

var _transition_player = (argument_count > 2) ? argument[2] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

_transition_player[? "to_background_color"] = argument[0];
_transition_player[? "to_background_alpha"] = argument[1];

return true;

#define tfx_to_use_surface
///@function tfx_to_use_surface(surface,stretch,[blend_alpha,transition_player])
///@arg surface
///@arg stretch
///@arg [blend_alpha,transition_player]

var _transition_player = (argument_count > 3) ? argument[3] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

var __linked_surface = argument[0];
var __stretch_surface = argument[1];

if (!surface_exists(__linked_surface)) {
	tfx_core_show_error("Given surface does not exist");
	return undefined;
}

_transition_player[? "to_linked_surface"] = __linked_surface;
_transition_player[? "to_linked_surface_stretch"] = __stretch_surface;
_transition_player[? "to_linked_surface_blend_alpha"] = (argument_count > 2) ? argument[2] : false;

return true;

#define tfx_transition_player_create
///@function tfx_transition_player_create()

var _transition_player = ds_map_create();

_transition_player[? "effect"] = -1;
ds_map_add_map(_transition_player,"effect_properties",ds_map_create());

_transition_player[? "show_transition"] = false;
_transition_player[? "show_debug"] = false;
_transition_player[? "automated_duration"] = 2500;
_transition_player[? "automated_start_time"] = 0;
_transition_player[? "automated_direction"] = 1;
_transition_player[? "automated_transitioning"] = false;
_transition_player[? "automated_hide_on_finish"] = false;
_transition_player[? "progress"] = 0;

//Resolution of transition surfaces
_transition_player[? "auto_size"] = true;
_transition_player[? "width"] = display_get_gui_width();
_transition_player[? "height"] = display_get_gui_height();

//Render surface
_transition_player[? "render_surface"] = surface_create(_transition_player[? "width"],_transition_player[? "height"]);

//From surface
_transition_player[? "from_surface"] = surface_create(_transition_player[? "width"],_transition_player[? "height"]);
_transition_player[? "from_background_color"] = c_black;
_transition_player[? "from_background_alpha"] = 0;
_transition_player[? "from_linked_surface"] = -1;
_transition_player[? "from_linked_surface_stretch"] = true;
_transition_player[? "from_linked_surface_blend_alpha"] = false;
_transition_player[? "from_initial_draw_complete"] = false;

//To surface
_transition_player[? "to_surface"] = surface_create(_transition_player[? "width"],_transition_player[? "height"]);
_transition_player[? "to_background_color"] = c_black;
_transition_player[? "to_background_alpha"] = 0;
_transition_player[? "to_linked_surface"] = -1;
_transition_player[? "to_linked_surface_stretch"] = true;
_transition_player[? "to_linked_surface_blend_alpha"] = false;
_transition_player[? "to_initial_draw_complete"] = false;

//Room Transition
_transition_player[? "room_transitioning"] = false;
_transition_player[? "room_transition_from"] = -1;
_transition_player[? "room_transition_to"] = -1;

//Add to global list
ds_list_add(global.__tfx_transition_players,_transition_player);
ds_list_mark_as_map(global.__tfx_transition_players,ds_list_size(global.__tfx_transition_players)-1);

return _transition_player;

#define tfx_transition_player_destroy
///@function tfx_transition_player_destroy(transition_player)
///@arg transition_player

var __transition_player = argument[0];

for (var _tp = 1; _tp < ds_list_size(global.__tfx_transition_players); _tp++) {
	var _tplr = global.__tfx_transition_players[| _tp];
	
	if (_tplr == __transition_player) {
		//remove transition player from the list
		ds_list_delete(global.__tfx_transition_players, _tp);
		
		//destroy the transition player
		ds_map_destroy(__transition_player[? "effect_properties"]);
		ds_map_destroy(__transition_player);
		
		return true;
	}
}

tfx_core_show_error("Transition player \"" + string(__transition_player) + "\" does not exist");
return undefined;

#define tfx_transition_player_exists
///@function tfx_transition_player_exists(transition_player)
///@arg transition_player

var __transition_player = argument[0];

for (var _tp = 0; _tp < ds_list_size(global.__tfx_transition_players); _tp++) {
	var _tplr = global.__tfx_transition_players[| _tp];
	
	if (_tplr == __transition_player) {
		return true;
	}
}

return false;

#define tfx_show_debug
///@function tfx_show_debug(enable,[transition_player])
///@arg enable
///@arg [transition_player]

var _transition_player = (argument_count > 1) ? argument[1] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

_transition_player[? "show_debug"] = argument[0];

return true;

#define tfx_is_playing
///@function tfx_is_playing([transition_player])
///@arg [transition_player]

var _transition_player = (argument_count > 0) ? argument[0] : global.__tfx_default_transition_player;

if (!tfx_transition_player_exists(_transition_player)) {
	tfx_core_show_error("Transition player \"" + string(_transition_player) + "\" does not exist");
	return undefined;
}

return _transition_player[? "automated_transitioning"];