
#region Methods
function setGrounded(_val) {
	grounded = _val;
	if (_val == false) {
		myFloor = noone;
	}
}

function checkJumpthrough(_x, _y) {
	var _output = noone;
	
	if (vspd >= 0 && place_meeting(_x, _y, oJumpthrough)) {
		var _list = ds_list_create();
		var _collisions = instance_place_list(_x, _y, oJumpthrough, _list, false);
		for (var i=0; i<_collisions; i++) {
			var _inst = _list[| i];
			if (floor(bbox_bottom) <= ceil(_inst.bbox_top - _inst.vspd)) {
				_output = _inst;
				break;
			}
		}
		ds_list_destroy(_list);
	}
	
	return _output;
}
#endregion

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

grounded = true;
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
myFloor = noone;
downJumpthroughFloor = noone;
myFloorhspd = 0;
floorMaxVspd = TERMINAL_VELOCITY;

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
