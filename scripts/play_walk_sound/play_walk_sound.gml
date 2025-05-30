// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_walk_sound(_image_index, _image_speed, _sound_indexes, _x, _y, _fmod_event = FMOD_EVENT.WALK){
	if(last_walk_index != floor(_image_index) and (((_image_index >= _sound_indexes[0]) and (_image_index < (_sound_indexes[0]+1)) and ((_image_index - _image_speed) < _sound_indexes[0])) or
	((_image_index >= _sound_indexes[1]) and (_image_index < (_sound_indexes[1]+1)) and ((_image_index - _image_speed) < _sound_indexes[1])))) {
		
		last_walk_index = floor(_image_index);
	
		
		var t = tilemap_get_at_pixel(global.ground_map, x, bbox_bottom + 10);
		var param;
		if(t == 0) {
			param = FMOD_PARAMETER_MOVE_WALK.WOOD
		} else if (t >= 1 and t < 100) { //terra
			param = FMOD_PARAMETER_MOVE_WALK.DIRT
		} else if (t >= 100 and t < 200) { //grama
			param = FMOD_PARAMETER_MOVE_WALK.GRASS
		} else if (t >= 200 and t < 275) { //areia
			param = FMOD_PARAMETER_MOVE_WALK.SAND
		} else if (t >= 275 and t < 500) { //pedra
			param = FMOD_PARAMETER_MOVE_WALK.STONE
		} else if (t >= 500 and t < 1100) { // arvore
			param = FMOD_PARAMETER_MOVE_WALK.WOOD
		} else { // pedra do indio
			param = FMOD_PARAMETER_MOVE_WALK.STONE
		}
		
		var _water = false;
		if(layer_exists(LAYER_WATER)) {
			var _water_tile = tilemap_get_at_pixel(layer_tilemap_get_id(LAYER_WATER), bbox_left, bbox_bottom-1);
			_water = _water_tile > 0;
		}
	
		if(_water) {
			emit_water(_x,_y-5,irandom_range(2,4));
			param = FMOD_PARAMETER_MOVE_WALK.WATER
		} else if(param == FMOD_PARAMETER_MOVE_WALK.DIRT) {
			emit_smoke(_x + (5*facing),bbox_bottom,0.1,0.3,1,1);	
		}
		o_sound_controller.update_event_parameter_and_play_pos(_fmod_event, FMOD_PARAMETER_NAME_MOVE, param, _x, _y);
	}
}