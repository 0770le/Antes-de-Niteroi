//game var
//create log obj
//drop by enemy ?
image_xscale = 0.5;
image_yscale = 0.5;

catalog_item_type = CATALOG_ITEM_TYPE.UNSET;

grav = global.grav;

death_protection = true;
collectible_index = 0;

log_title = "Teste";
log = "logs.LOG_PARENT";

vsp_initial = 0; //random_range (-6,-3);
vsp = vsp_initial;
hsp_initial = 0; //random_range(2,5) * choose(-1,1);
hsp = hsp_initial;
hsp_decimal = 0;
vsp_decimal = 0;
drag = 0.1;
die = false;

//pick clour
image_index = irandom(image_number -1); //começa em zero
//has bounce happened yet?
bounce = false;
//can player pick up this yet?
can_pickup = false;

//enable light
light_id = instance_create_layer(x,y, LAYER_EFFECTS, o_light);
light_id.type = 4;
//get the gem colour
light_id.col_index = image_index;