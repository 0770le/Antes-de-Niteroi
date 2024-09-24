event_inherited();

image_speed =1;
mask_index = mask_array[state];


if !can_fire {
	fire_delay--;
	if fire_delay < 0 {
		can_fire = true;
	}
}

