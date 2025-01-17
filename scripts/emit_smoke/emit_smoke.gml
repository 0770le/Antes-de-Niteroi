function emit_smoke(xPos, yPos, minSize, maxSize, radius, ammount, spdMin=0, spdMax=0.2, spdInc = 0, dirMin=0, dirMax=359, distribution = ps_distr_gaussian) {
	with(SmokeParticle){
	    part_type_size(partSmoke, minSize, maxSize, 0, 0);
		
		
		part_type_speed(partSmoke,spdMin,spdMax,spdInc,0);
		part_type_direction(partSmoke,dirMin,dirMax,0,0);

	    x = xPos;
	    y = yPos;
	    part_emitter_region(particleSystem,partSmoke_emit,x-radius,x+radius,y-radius,y+radius,ps_shape_ellipse,ps_distr_gaussian);
	    part_emitter_burst(particleSystem,partSmoke_emit,partSmoke,ammount*2);
	}
}
