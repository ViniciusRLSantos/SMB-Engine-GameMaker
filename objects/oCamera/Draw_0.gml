if !(debug_mode) exit;
//draw_self();
//draw_circle(xTo, yTo, 3, false);

var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);
var ww = display_get_gui_width(); //camera_get_view_width(view_camera[0]);
var hh = display_get_gui_height();//camera_get_view_height(view_camera[0]);

draw_rectangle(xx+2, yy+2, xx+ww-2, yy+hh-2, true);
/*
var _xx = (xx + ww/2),
	_yy = (yy+24);
draw_circle(_xx, _yy, 8, false)