enum max_arrow_location{
	UPGRADE_KERYI,
	UPGRADE_MORGUJA
}


location = max_arrow_location.UPGRADE_KERYI;

vsp_initial = 0;
vsp = 0;
hsp_initial = 0;
hsp = 0;
hsp_decimal = 0;
vsp_decimal = 0;
drag = 0.1;
die = false;
death_protection = true;

//pick clour
image_index = irandom(image_number -1); //começa em zero
//has bounce happened yet?
bounce = false;
//can player pick up this yet?
can_pickup = false;

//enable light
var inst = instance_create_layer(x,y, LAYER_EFFECTS, o_light);
light_id = inst.id;
inst.type = 5;

alarm[0] = 2;