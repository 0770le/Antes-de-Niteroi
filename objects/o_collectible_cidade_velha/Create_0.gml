//game var
//create log obj
//drop by enemy ?

log_title = "Cidade Velha";
log = "logs.LOG_PARENT";

vsp_initial  = random_range (-6,-3);
vsp = vsp_initial;
hsp_initial = random_range(2,5) * choose(-1,1);
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
var inst = instance_create_layer(x,y, LAYER_EFFECTS, o_light);
light_id = inst.id;
inst.type = 4;
//get the gem colour
inst.col_index = image_index;