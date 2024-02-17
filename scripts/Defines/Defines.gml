// Constants
#macro GRAVITY 0.15
#macro COYOTE 5
#macro JUMP_BUFFER 8
#macro HIT_TIMER room_speed*2
#macro DESPAWN_TIME room_speed/2

draw_set_font(fntGame);

// Enums
enum ITEM {
	MUSHROOM=0,
	FIREFLOWER=1,
	LEAF=2,
	HAMMERSUIT=3,
	ONEUP=4
}

enum POWER {
	MARIODEAD,
	MARIOMUSH,
	MARIOFIRE,
	MARIOLEAF,
	MARIOHAMMER
}