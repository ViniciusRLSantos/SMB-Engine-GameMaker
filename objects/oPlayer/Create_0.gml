minspd = 2;
maxspd = 3;
spd = 2;
climb_spd = 1;

carry = CARRY.NOTHING;
running = false;
kick_frames = 0;

hspd = 0;
vspd = 0;
jumpspd = -5;
dir = 1;
hdir = 1;
hspd_add = 0;

jump_buffer = 0;
coyote_timing = 0;

acc_g = 0.085;
fric_g = 0.045;
acc_a = 0.080;
fric_a = 0.030;

block_strength = 1;
hp = 1;
powerUp = noone;

hit = false;

#region Define Skins
MiniSkin = new MarioSkin(
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
	sMiniMarioRunJump,
	sMiniMarioCarry,
	sMiniMarioKick
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
	sBigMarioRunJump,
	sBigMarioCarry,
	sBigMarioKick
);

FireSkin = new MarioSkin(
	maskMarioBig,
	sFireMarioIdle, 
	sFireMarioWalk,
	sMiniMarioDeath,
	sFireMarioCrouch,
	sFireMarioJump,
	sFireMarioFall,
	sFireMarioRun,
	sFireMarioSwim,
	sFireMarioTurn,
	sFireMarioClimb,
	sFireMarioRunJump,
	sFireMarioCarry,
	sFireMarioKick
);

HammerSkin = new MarioSkin(
	maskMarioBig,
	sHammerMarioIdle, 
	sHammerMarioWalk,
	sMiniMarioDeath,
	sHammerMarioCrouch,
	sHammerMarioJump,
	sHammerMarioJump,
	sHammerMarioRun,
	sHammerMarioSwim,
	sHammerMarioTurn,
	sHammerMarioClimb,
	sHammerMarioRunJump,
	sHammerMarioCarry,
	sHammerMarioKick
);
#endregion

sprite = MiniSkin;
mask_index = sprite.collision_mask;
current_sprite = sprite.idle;

state = player_ground;

depth = -100
