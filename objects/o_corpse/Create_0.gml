vsp_initial  = random_range(-5,-2);
vsp = vsp_initial;
facing = 1;
hsp_initial = random_range(1.7,2);
hsp = hsp_initial;
hsp_decimal = 0;
vsp_decimal = 0;
drag = 0.01;

//pick one sprite
//image_index = irandom(image_number -1); //começa em zero
//has bounce happened yet?
bounce = 0;
image_speed = 1;
image_index = 0;


sprite_ref = noone;
sound_ref= noone;

type = 0;
//0 frances
//1 tupinamba
//2 tupinamba_melee
//3 armadeira
//4 jararaca

function corpse(){
	if (sprite_ref == noone) {
	switch(type) {
		case 0:
			//frances
			sprite_ref = s_frances_die;
			sound_ref= noone;
		break;
		
		case 1:
			//tupinamba
			sprite_ref = s_tupinamba_die;
			sound_ref= noone;
		break;
		
		case 2:
			//tupinamba_melee
			sprite_ref = s_tupinamba_melee_die;
			sound_ref= noone;
		break;
	}
}


}