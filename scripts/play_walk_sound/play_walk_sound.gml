// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_walk_sound(_image_index, _image_speed, _sound_indexes, _x, _y){
	var _tile = undefined;
	if(((_image_index >= _sound_indexes[0]) and (_image_index < (_sound_indexes[0]+1)) and ((_image_index - _image_speed) < _sound_indexes[0])) or
	((_image_index >= _sound_indexes[1]) and (_image_index < (_sound_indexes[1]+1)) and ((_image_index - _image_speed) < _sound_indexes[1]))) {
		var t = tilemap_get_at_pixel(global.ground_map, x, bbox_bottom + 10);
		var param;
		if (t >= 100 and t < 200) { //terra
			param = FMOD_PARAMETER_MOVE_WALK.DIRT
		} else if (t >= 100 and t < 200) { //grama
			param = FMOD_PARAMETER_MOVE_WALK.GRASS
		} else if (t >= 200 and t < 275) { //areia
			param = FMOD_PARAMETER_MOVE_WALK.STONE
		} else if (t >= 275 and t < 375) { //pedra
			param = FMOD_PARAMETER_MOVE_WALK.SAND
		} else { // se nao for nada, arvore
			param = FMOD_PARAMETER_MOVE_WALK.TREE
		}
		
		o_sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.WALK, FMOD_PARAMETER_NAME_MOVE, param, _x, _y)
		_tile = param;
	}
	
	return _tile;
}