event_inherited();

if (instance_exists(oPlayer)) {
	dir = arctan2(oPlayer.y-self.y, oPlayer.x-self.x);
	if (sign(oPlayer.x - self.x) != 0) player_side = sign(oPlayer.x - self.x);
	
	chasing = (oPlayer.state != player_death && oPlayer.dir == player_side);
}
current_dir = lerp(current_dir, dir, 0.1);
if (in_view_x()) {
	hspd = approach(hspd, chasing*cos(dir)*spd, acc);
	vspd = approach(vspd, chasing*sin(dir)*spd, acc);
	if (chasing) alpha = lerp(alpha, 1, 0.05); else alpha = lerp(alpha, 0.5, 0.05);
	
} else {
	hspd = 0;
	vspd = 0;
	chasing = false;
	alpha = 0.5;
}
x+=hspd;
y+=vspd;
