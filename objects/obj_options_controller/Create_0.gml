#macro OPTIONS_FULLSCREEN		"fullscreen"
#macro OPTIONS_MASTER_ENABLED	"master_enabled"
#macro OPTIONS_MASTER_VOLUME	"master_volume"
#macro OPTIONS_MUSIC_ENABLED	"music_enabled"
#macro OPTIONS_MUSIC_VOLUME		"music_volume"
#macro OPTIONS_SFX_ENABLED		"sfx_enabled"
#macro OPTIONS_SFX_VOLUME		"sfx_volume"

// saveables

options = new OptionsModel();

// transients

listeners	= ds_map_create();
savefile	= "options.rec";

#region events

function register_listener(_listener = noone)
{
	listeners[? _listener.id] = _listener;
}

function unregister_listener(_listener = noone)
{
	ds_map_delete(listeners, _listener.id);
}

function notify_listeners() 
{
    var _listeners = ds_map_values_to_array(listeners, []);
	
	for (var _i = 0; _i < array_length(_listeners); _i++)
	{
		_listeners[_i].on_options_change(self.options); 
	}
}

#endregion

#region persistance

function write_all()
{
	var _json = json_stringify(options, true);
	
	var _savefile = file_text_open_write(savefile);
	
	file_text_write_string(_savefile, _json);
	
	file_text_close(_savefile);
}

function read_all()
{
	global.logger.debug($"reading log file {filename_path(savefile)}{savefile}");
	
	try {
		
		var _savefile = file_text_open_read(savefile);
	
		var _json = file_text_read_string(_savefile);
	
		var _options_model = json_parse(_json);
	
		options = new OptionsModel(_options_model);	
	} catch (_e) {
		
		global.logger.error("failed to load options file");
		
		options = new OptionsModel();
		
		write_all();
	}
}

#endregion

function save_and_notify()
{
	write_all();
	
	notify_listeners();
}

function get_option(_option_macro = OPTIONS_FULLSCREEN)
{
	return options[$ _option_macro];
}

function set_option(_option_macro = OPTIONS_FULLSCREEN, _new_value = 0)
{
	options[$ _option_macro] = _new_value;
	
	save_and_notify();
}

function register_listeners()
{
	with(o_camera) other.register_listener(self);
}

function init()
{
	global.options_controller = self;
	
	register_listeners();
	
	if (file_exists(savefile))
	{
		read_all();
	}
	else 
	{
		write_all();
	}
	
	notify_listeners();
}

init();