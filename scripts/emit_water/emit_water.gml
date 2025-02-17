function emit_water(xPos, yPos, ammount) {
	with(o_water_particle){
	    x = xPos;
	    y = yPos;
		_radius = 5;
	    part_emitter_region(particleSystem,partWater_emit,x-_radius,x+_radius,y-_radius,y+_radius,ps_shape_ellipse,ps_distr_linear);
	    part_emitter_burst(particleSystem,partWater_emit,partWater,ammount);
	}
}
