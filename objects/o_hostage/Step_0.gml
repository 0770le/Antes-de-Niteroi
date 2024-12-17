
//movement 
calc_entity_movement();
 
//collision
collision();

stare(); 
image_xscale = facing;

if saved {
	image_index = 1;
	
	if !runned_once{
		//get layer id
		//var layer_id = layer_get_id("Travel"); 
		////activate layer
		//instance_activate_layer(layer_id);
		runned_once = true;
	}
	
	//destroy if leave screen
	if (!on_screen(200)) {
		instance_destroy(self);
	}
}
