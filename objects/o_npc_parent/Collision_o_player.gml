/// @description show message
if(talk and other.up) {
	show_msg(msgs[min(array_length(msgs)-1, quest_step)], 2);
	quest = false;
}
