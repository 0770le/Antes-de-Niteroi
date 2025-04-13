bird_type = choose(0,1,2);
set_flock = false;
call_later(5, time_source_units_frames, function() {set_flock = true;}, false);

	
