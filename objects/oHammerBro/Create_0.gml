walk_dir = 1;
facing = 1;
hspd = 0;
hspd_add = 0;
vspd = 0;
spd = random_range(0.35, 0.5);
jumpspd = -5;
dir = choose(-1, 1);

sprite = new EnemyBroSkin(maskEnemy16, noone, sHammerBroIdle, sHammerBroDeath, sHammerBroDeath, sHammerBroGrab);

throw_timer = irandom_range(room_speed/2, room_speed*2);
jump_timer = irandom_range(room_speed/2, room_speed*2);

state = HammerBroWander;