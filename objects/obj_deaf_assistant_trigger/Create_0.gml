// settings

captions			= "PlaceHolder";

// controls

already_shown		= false;

function show_captions() 
{
	if (already_shown) return;
	
	var _xx = ((bbox_right - bbox_left) / 2) + bbox_left;
	
	global.deaf_assistant.show_captions_pos(captions, _xx);
	
	already_shown = true;
}
