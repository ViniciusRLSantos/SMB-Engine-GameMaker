function Skin(_collision_mask, _idle, _walk, _death) constructor {
	collision_mask = _collision_mask;
	idle = _idle;
	walk = _walk;
	death = _death;
}

function MarioSkin(_collision_mask, _idle, _walk, _death, _duck, _jump, _fall, _run, _swim, _turn, _climb, _runjump, _carry, _kick, _attack=noone) 
: Skin(_collision_mask, _idle, _walk, _death) constructor {
	jump = _jump;
	fall = _fall;
	run = _run;
	swim = _swim;
	turn = _turn;
	climb = _climb;
	runjump = _runjump;
	carry = _carry;
	kick = _kick;
	attack = _attack;
}

function BasicEnemySkin(_collision_mask, _idle=noone, _walk, _death, _knocked)
: Skin(_collision_mask, _idle, _walk, _death) constructor {
	knocked = _knocked;
}
function EnemyBroSkin(_collision_mask, _idle=noone, _walk, _death, _knocked, _grab)
: Skin(_collision_mask, _idle, _walk, _death) constructor {
	knocked = _knocked;
	grab = _grab;
}
