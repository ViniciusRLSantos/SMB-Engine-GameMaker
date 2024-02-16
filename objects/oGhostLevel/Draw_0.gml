if (!surface_exists(surf)) {
	surf = surface_create(room_width, room_height);
}

surface_set_target(surf);
draw_clear_alpha(0, 0);
draw_clear_alpha(0, 1.0);
surface_reset_target();

if !(instance_exists(oPlayer)) exit;

shader_set(shdLighting);
shader_set_uniform_f(position, oPlayer.x, oPlayer.y-oPlayer.sprite_height/2);
shader_set_uniform_f(radius, r);
shader_set_uniform_f(lightMargin, lm);
shader_set_uniform_f(alpha, 0.5);

draw_surface(surf, 0, 0);
shader_reset();