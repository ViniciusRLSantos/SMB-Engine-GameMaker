if (instance_exists(target)) {
	xTo = target.x;
	yTo = target.y-target.sprite_height/2;
}
if (!fixed_x) x += (xTo - x)/2;
if (!fixed_y) y += (yTo - y)/2;
x = clamp(x, game_width*zoom/2, room_width-game_width*zoom/2);
y = clamp(y, game_height*zoom/2, room_height-game_height*zoom/2);

if (keyboard_check_pressed(ord("F"))) filter = (filter+1) mod 2

zoom = lerp(zoom, zoom_to, 0.2);
zoom_to += 0.25*(mouse_wheel_up() - mouse_wheel_down())
zoom_to = clamp(zoom_to, 0.25, 4)
