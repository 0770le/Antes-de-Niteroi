
function player_bow_display_state(){

facing = -1;
can_take_dmg = false;

//arrow shoot
if (image_index > 22 and !runned_once){
	
	//rising arrow
	var inst = instance_create_layer(x+20*facing,y - 28, LAYER_PROJECTILES, o_player_rising_arrow);
	inst.facing = facing;
	global.sound_controller.update_event_parameter_and_play_pos(FMOD_EVENT.ATTACK_BOW, FMOD_PARAMETER_NAME_MOVE, FMOD_PARAMETER_ATTACK_BOW_VALUE.RELEASE, x, y);
	inst.image_index = 0;	
	runned_once = true;
}

//leave state
if (anim_end() and runned_once) {
	state = states.IDLE;
	runned_once = false;
	can_take_dmg = true;
}

calc_entity_movement();
collision();
anim();
}