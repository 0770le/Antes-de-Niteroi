/// @description Insert description here
// You can write your code in this editor

//get_menu_input_all();
if(keyboard_check(vk_escape))
	jump = true;
	
if((screenAlpha <= 0 and duration > 0) or jump) {
	duration = 0;
}
	

if(duration-- <= 0){
	
	screenAlpha+= 0.02;	
	if(screenAlpha > 1){
		room_goto_next();
	}
} else if(screenAlpha > 0){
	screenAlpha-= 0.02;	
}






