hspd = 0;
vspd = 0;

bonked = false;
offset = 6;
yy = y;

spawnItem = function() {
	if (oPlayer.hp < 2) item_to_spawn = ITEM.MUSHROOM;
	with (instance_create_depth(x, y, -10, oItem)) {
		type = other.item_to_spawn;
		audio_play_sound(sndItemSprout, 10, 0);
	}
}

spawnCoin = function() {
	if (coins > 1) {
		yy -= offset;
		alarm[0] = 5;
		global.coins++;
		coins--;
		audio_play_sound(sndCoin, 10, 0);
		instance_create_depth(x, y, depth + 1, oCoinSprout);
	} else {
		yy -= offset;
		global.coins++;
		coins--;
		audio_play_sound(sndCoin, 10, 0);
		instance_create_depth(x, y, depth + 1, oCoinSprout);
		sprite_index = sBlockNull;
	}
}

show_debug_message($"Sprite: {sprite_get_name(sprite)}")
