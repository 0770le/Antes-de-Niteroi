function breathing(){
if breath_timer <0 {
//start breath anim
	image_speed = 1;
} else{
	breath_timer --;
}	
//stop breathing in the end of animation
	if image_index >= image_number - image_speed {
		breath_timer = breath_timer_initial;
		//pause at first frame
		image_index=0;
		image_speed=0;
	}
}