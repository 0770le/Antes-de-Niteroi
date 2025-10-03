
//movement 
calc_entity_movement();
 
//collision
collision();

stare(); 
image_xscale = facing;

if(!saved and distance_to_object(o_player) < 100) {
	saved = true;
	o_player.update_save();
	
	var _text = global.i18n.get_message("tip-checkpoint-saved");
	var _text_len = string_length(_text);
	
	text_bubble2(id, _text, _text_len * 10, 3.5, TEXT_Y_HEIGHT_1l);

}
