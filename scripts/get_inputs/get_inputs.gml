function get_inputs(){
	kRight = keyboard_check(vk_right);
	kLeft = keyboard_check(vk_left);
	kDown = keyboard_check(vk_down);
	kUp = keyboard_check(vk_up);
	kDownPressed = keyboard_check_pressed(vk_down);
	kUpPressed = keyboard_check_pressed(vk_up);
	kJump = keyboard_check_pressed(ord("Z"));
	kRun = keyboard_check(ord("X"));
	kSpecial = keyboard_check_pressed(ord("X"));
	kJumpReleased = keyboard_check_released(ord("Z"));
	kJumpHeld = keyboard_check(ord("Z"));
	
}