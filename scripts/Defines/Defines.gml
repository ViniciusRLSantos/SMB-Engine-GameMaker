// Constants
#macro GRAVITY 0.15
#macro COYOTE 5
#macro JUMP_BUFFER 8
#macro HIT_TIMER room_speed*2
#macro DESPAWN_TIME room_speed/2

#macro P_DECREASE_ON_WALL	0.0225
#macro P_DECREASE			0.020
#macro P_DECREASE_FAST		0.065
#macro P_INCREASE			0.0175

draw_set_font(fntGame);

// Enums
enum OWNER {
	PLAYER,
	ENEMY
}

enum ITEM {
	MUSHROOM=0,
	FIREFLOWER=1,
	LEAF=2,
	HAMMERSUIT=3,
	ONEUP=4
}

enum POWER {
	MARIODEAD=1000,  // Not really a powerup but...
	MARIOMUSH=0,
	MARIOFIRE=1,
	MARIOLEAF=2,
	MARIOHAMMER=3
}