function emit_explosion(xPos, yPos, radius, ammount, distribution = ps_distr_linear, spd = 0, dir = 180, partDepth = -10000, partAlpha = 1) {
	with(o_explosion_particle){
		part_system_depth(particleSystem, partDepth);
		
		part_type_alpha1(partSmExp,partAlpha);
		part_type_alpha1(partSmExpDon,partAlpha);
		
		part_type_speed(partSmExp, spd, spd, 0, 0);
		part_type_speed(partSmExpDon, spd, spd, 0, 0);
		
		part_type_direction(partSmExp,dir,dir,0,0);
		part_type_direction(partSmExpDon,dir,dir,0,0);
		
	    part_emitter_region(particleSystem,partExplosion_emit,xPos-radius,xPos+radius,yPos-radius,yPos+radius,ps_shape_ellipse,distribution);
	    part_emitter_burst(particleSystem,partExplosion_emit,partSmExp,ammount);
	    part_emitter_burst(particleSystem,partExplosion_emit,partSmExpDon,ammount);
	}
}