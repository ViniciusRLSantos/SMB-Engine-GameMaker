if (canSuffocate && place_meeting(x, y-1, oBlock) && place_meeting(x, y+1, oBlock)) {
	if state != knocked_state {
		vspd = jumpspd;
		audio_stop_all();
		audio_play_sound(sndDeath, 10, 0);
		state = knocked_state;
	}
}
