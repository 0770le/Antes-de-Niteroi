event_inherited();

image_speed =1;
mask_index = mask_array[state];

//sprite de atirar ta virado pq pegou do player
if state == tupinamba_states.SHOOT {
	image_xscale *= -1;
} else {
	image_xscale *=1;
}

if !can_fire {
	fire_delay--;
}