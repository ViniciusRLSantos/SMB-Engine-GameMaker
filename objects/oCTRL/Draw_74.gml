//surface_set_target(view_get_surface_id(0));

#region Draw Held Item
var xx = camera_get_view_width(view_camera[0])/2;
var yy = 24;
draw_sprite(sItemFrame, 0, floor(xx), yy);
if global.hold_item != noone {
	switch(global.hold_item) {
		case POWER.MARIOMUSH:
			draw_sprite(sMushroom, 0, xx-8, yy);
		break;
		
		case POWER.MARIOFIRE:
			draw_sprite(sFireFlower, 0, xx-8, yy);
		break;
		
		case POWER.MARIOHAMMER:
			draw_sprite(sHammerSuit, 0, xx-8, yy);
		break;
		
		case POWER.MARIOLEAF:
			draw_sprite(sLeaf, 0, xx-8, yy);
		break;
	}
}
#endregion

//surface_reset_target();
/*var xx = 16, yy = display_get_gui_height()-24;

if (global.pmeter >= global.maxPmeter) {
	if !(p_charged) {
		p_charged = true;
		alarm[0] = room_speed*1.25;
	}
	
	var _time = shader_get_uniform(shdRainbow, "time");
	var _speed = shader_get_uniform(shdRainbow, "speed");
	var _saturation = shader_get_uniform(shdRainbow, "saturation");
	var _brightness = shader_get_uniform(shdRainbow, "brightness");
	time++;
	if !(audio_is_playing(sndRun)) && global.p_spd_boost != 0 {
		audio_play_sound(sndRun, 10, 0, 1.0, 0, 1.75);
	}
	shader_set(shdRainbow);
	shader_set_uniform_f(_time, time);
	shader_set_uniform_f(_speed, -0.02);
	shader_set_uniform_f(_saturation, 0.75);
	shader_set_uniform_f(_brightness, 0.85);
} else {
	p_charged = false;
	global.p_spd_boost = 0;
}

draw_rectangle(xx, yy, xx+(global.pmeter/global.maxPmeter)*pbar_length, yy+5, false);
shader_reset();
draw_sprite_stretched(sBar, 0, xx-1, yy-1, pbar_length+4, 8);