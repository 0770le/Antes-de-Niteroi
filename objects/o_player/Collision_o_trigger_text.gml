/// @description display info
var str, key, pad;
if (gamepad_is_connected(0)) {
	pad = true;
} else {
	pad = false;
}

//has it been seen?
var s = other.tooltip;

if (!global.tooltip[# s, 5]) {
	//create string (check o_game.create.tooltip msg)
	str = global.tooltip[# s, 0] + " " + global.tooltip[# s, 2 + pad] + " " + global.tooltip[# s, 1];
	
	//show_msg 
	show_msg(str, global.tooltip[# s, 4]);
	
	//update tootip as it's been seen
	global.tooltip[# s, 5] = 1;
}


//destroy trigger
instance_destroy(other);


