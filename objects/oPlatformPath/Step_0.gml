playerTop = place_meeting(x, y-1, oPlayer);
playerSideR = place_meeting(x+spd+1, y, oPlayer);
playerSideL = place_meeting(x-spd-1, y, oPlayer);
playerBottom = place_meeting(x, y+spd+1, oPlayer);

if (playerBottom) {
	with (oPlayer) {
		y+=other.spd;
		vspd = 1;
	}
}