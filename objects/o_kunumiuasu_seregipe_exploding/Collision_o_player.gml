show_interact_key = true;

var _text = global.i18n.get_message("tip-get-out");
	
text_bubble2(id, _text, -1, 4, TEXT_Y_HEIGHT_2l);


if other.interact and interact{
	global.sound_controller.update_position_and_play(FMOD_EVENT.TRANSITION_BOAT, x, y);

	target_rm = rm_cidade_velha;
	target_x = 1619;
	target_y = 415;
	
	
	var _catalog_item_type = CATALOG_ITEM_TYPE.ITAOKA_FORT;
	global.catalog_controller.unlock_item(_catalog_item_type);

	_catalog_item_type = CATALOG_ITEM_TYPE.MARANA_UASU;
	global.catalog_controller.unlock_item(_catalog_item_type);

	_catalog_item_type = CATALOG_ITEM_TYPE.PARANACUPU;
	global.catalog_controller.unlock_item(_catalog_item_type);
		
	
	global.fader.to_room(target_rm, target_x, target_y,true);
	
	interact = false;
}
