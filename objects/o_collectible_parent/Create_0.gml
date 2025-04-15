image_xscale = 0.5;
image_yscale = 0.5;

catalog_item_type = CATALOG_ITEM_TYPE.UNSET;

death_protection = true;
collectible_index = 0;

log_title = "Teste";
log = "logs.LOG_PARENT";

die = false;

//pick colour
image_index = irandom(image_number -1); //começa em zero

//enable light
light_id = instance_create_layer(x,y, "Instances", o_light);
light_id.type = 4;
//get the gem colour
light_id.col_index = image_index;

alarm[0]=2;