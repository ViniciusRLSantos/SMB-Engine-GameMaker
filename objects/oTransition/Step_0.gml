/*
if (transition) {
	application_surface_draw_enable(false);
	if (!switched) {
		amount = max(10, amount - 1);
		if (amount <= 10) {
			switched = true;
			room_goto(room_target);
		}
	} else {
		amount = min(100, amount + 1);
		if (amount >= 100) {
			transition = false;
			switched = false;
			application_surface_draw_enable(true);
		}
	}
}