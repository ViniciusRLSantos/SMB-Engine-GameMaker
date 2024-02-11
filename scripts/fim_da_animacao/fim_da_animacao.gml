function fim_da_animacao(_sprite = sprite_index, _image = image_index, _spd = sprite_get_speed(sprite_index) * image_speed){
	var _type = sprite_get_speed_type(_sprite);
	if (_type == spritespeed_framespersecond) {
		_spd = _spd/room_speed;
	}
	
	return _image + _spd >= sprite_get_number(_sprite);
}