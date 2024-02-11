function get_inputs(){
	kRight = keyboard_check(vk_right);
	kLeft = keyboard_check(vk_left);
	kJump = keyboard_check_pressed(ord("Z"));
	kRun = keyboard_check(ord("X"));
	kSpecial = keyboard_check_pressed(ord("X"));
	kJumpReleased = keyboard_check_released(ord("Z"));
	kJumpHeld = keyboard_check(ord("Z"));
	
}