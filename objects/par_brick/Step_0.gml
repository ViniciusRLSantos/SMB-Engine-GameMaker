// Inherit the parent event
event_inherited();
yy = lerp(yy, ystart, 0.20);
yy = clamp(yy, ystart-offset, ystart);
script_execute(mode);