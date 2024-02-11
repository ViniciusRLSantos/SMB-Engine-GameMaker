minspd = 2;
maxspd = 3;
spd = 2;
grav = GRAVITY;
hspd = 0;
vspd = 0;
jumpspd = -5;
running = false;
dir = 1;

jump_buffer = 0;
coyote_timing = 0;

acc_g = 0.15;
fric_g = 0.085;
acc_a = 0.125;
fric_a = 0.04;

block_strength = 1;
hp = 1;

#region Define Skins
miniSkin = new MarioSkin(
	maskMarioSmall,
	sMiniMarioIdle, 
	sMiniMarioWalk,
	sMiniMarioDeath,
	sMiniMarioCrouch,
	sMiniMarioJump,
	sMiniMarioFall,
	sMiniMarioSprint,
	sMiniMarioSwim,
	sMiniMarioTurn,
	sMiniMarioClimb,
	sMiniMarioRunJump
);
BigSkin = new MarioSkin(
	maskMarioBig,
	sBigMarioIdle, 
	sBigMarioWalk,
	sMiniMarioDeath,
	sBigMarioCrouch,
	sBigMarioJump,
	sBigMarioFall,
	sBigMarioRun,
	sBigMarioSwim,
	sBigMarioTurn,
	sBigMarioClimb,
	sBigMarioRunJump
);
#endregion

sprite = miniSkin;
mask_index = sprite.collision_mask;

state = player_ground;