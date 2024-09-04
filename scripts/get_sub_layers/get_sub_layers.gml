///@descr 
function get_sub_layers(_layer_name = LAYER_GUI) {
	var _filtered_layers = [];
	
	var _layers = layer_get_all();
	
	for (var _i = 0; _i < array_length(_layers); ++_i) 
	{
		var _name = layer_get_name(_layers[_i]);
		
		if (_layer_name != _name && string_starts_with(_name, _layer_name))
		{
			array_push(_filtered_layers, _layers[_i]);
		}
	}
	
	return _filtered_layers;
}
