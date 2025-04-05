//show_msg("Aperte o direcional para cima para viajar:\nother.destination", 2);

show_interact_key = true;


if other.interact {
	switch(room) {
		case rm_keryi:
			target_rm = rm_keryi_hut;
			target_x = 179;
			target_y = 207;
			break;
		case rm_keryi_hut:
			target_rm = rm_keryi;
			target_x = 152;
			target_y = 847;
			break;
	}
	var _aux = {
		rm: target_rm,
		x: target_x,
		y: target_y,
		facing: other.facing,
		callback: function () {
			fade_to_room(self.rm, self.x, self.y, self.facing, c_black);		
		}
	}
	var _ = call_later(2, time_source_units_seconds, _aux.callback);
}
