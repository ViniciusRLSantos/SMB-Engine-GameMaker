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
