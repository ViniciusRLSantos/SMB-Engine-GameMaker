if (instance_exists(oPlayer)) {
	if (playerTop) {
		with (oPlayer) {
			hspd_add = other.x-other.xprevious;
			y += other.y-other.yprevious;
		}
	}
	if (playerSideR) {
		with (oPlayer) {
			x += abs(other.x-other.xprevious);
		}
	}
	if (playerSideL) {
		with (oPlayer) {
			x -= abs(other.x-other.xprevious);
		}
	}
	if (playerBottom) {
		with(oPlayer) {
			y+=other.y-other.yprevious;
			vspd = 0;
		}
	}
	
}
//path.path