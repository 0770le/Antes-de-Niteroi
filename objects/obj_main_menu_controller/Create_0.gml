event_inherited();

// settings

starting_x		= 140;
starting_y		= 168;
items_margin    = 25;
button_sprite   = spr_menu_button_transparent;
text_color		= c_white;
text_hover_color= make_color_rgb(172, 50, 50);
font_description= fnt_arial_very_large;

// controls

scale			= 3;
width			= 480 * scale;
height			= 270 * scale;
accent_color	= c_white;

is_open			= true;
is_closeable	= false;

x				= width / 2;
y				= height / 2;

left			= 0;
right			= width;
top				= 0;
bottom			= height;

margin_left		= 20;
margin_right	= 20;
margin_bottom	= 30;
margin_top		= 30;

fullscreen_button   = noone;
volume_master       = noone;
volume_music		= noone;
volume_sfx          = noone;
deaf_assistance		= noone;

function draw_title()
{
	
}

function draw_controller_buttons()
{
	
}

function draw_controller_buttons2()
{
	draw_set_color(accent_color);
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_right);
	
	var _scale = global.input_manager.get_input_sprite_scale();	
	
	//var _cancel_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CANCEL);
	//draw_text(right - (sprite_get_width(_cancel_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 36, "Voltar");
	//draw_sprite_ext(_cancel_sprite, 0, right - margin_right, bottom - margin_bottom - 36, _scale, _scale, 0, c_white, 1.0);
			
	var _confirm_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CONFIRM);
	draw_text(right - (sprite_get_width(_confirm_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 1, "Confirmar");
	draw_sprite_ext(_confirm_sprite, 0, right - margin_right, bottom - margin_bottom - 1, _scale, _scale, 0, c_white, 1.0);
}

function draw_parent()
{
	
}

function draw_gui()
{
	draw_controller_buttons2();
	draw_version();
}

function draw()
{
	draw_title();
	
	draw_menu_items();
}

function add_options_button()
{
	var _options_node = root_menu.add_child(new MenuNode("Opções"))
	fullscreen_button = _options_node.add_child(new MenuCheckbox("Tela Cheia", function ()
	{
		var _is_fullscreen = global.options_controller.get_option(OPTIONS_FULLSCREEN);
		
		global.options_controller.set_option(OPTIONS_FULLSCREEN, !_is_fullscreen);
	}));
	fullscreen_button.set_checked(global.options_controller.options.fullscreen);
	
	volume_master = _options_node.add_child(new MenuInteger("Volume Geral", 
	function ()
	{
		volume_master.set_value(volume_master.value - 1);
		
		global.options_controller.set_option(OPTIONS_MASTER_VOLUME, volume_master.value);
	}, 
	function () 
	{
		volume_master.set_value(volume_master.value + 1);
		
		global.options_controller.set_option(OPTIONS_MASTER_VOLUME, volume_master.value);
	}));
	volume_master.set_value(global.options_controller.options.master_volume);
	
	volume_music = _options_node.add_child(new MenuInteger("Música", 
	function ()
	{
		volume_music.set_value(volume_music.value - 1);
		
		global.options_controller.set_option(OPTIONS_MUSIC_VOLUME, volume_music.value);
	}, 
	function () 
	{
		volume_music.set_value(volume_music.value + 1);
		
		global.options_controller.set_option(OPTIONS_MUSIC_VOLUME, volume_music.value);
	}));
	volume_music .set_value(global.options_controller.options.music_volume);
	
	volume_sfx = _options_node.add_child(new MenuInteger("Efeitos", 
	function ()
	{
		volume_sfx.set_value(volume_sfx.value - 1);
		
		global.options_controller.set_option(OPTIONS_SFX_VOLUME, volume_sfx.value);
	}, 
	function () 
	{
		volume_sfx.set_value(volume_sfx.value + 1);
		
		global.options_controller.set_option(OPTIONS_SFX_VOLUME, volume_sfx.value);
	}));
	volume_sfx.set_value(global.options_controller.options.sfx_volume);
	deaf_assistance = _options_node.add_child(new MenuCheckbox("Ajuda para Surdos", function ()
	{
		var _is_deaf_assistance = global.options_controller.get_option(OPTIONS_DEAF_ASSISTANCE);
		
		global.options_controller.set_option(OPTIONS_DEAF_ASSISTANCE, !_is_deaf_assistance);
	}));
	deaf_assistance.set_checked(global.options_controller.options.deaf_assistance);
}

function init_dependencies()
{
	// persistants
	if (!instance_exists(o_sound_controller))
		instance_create_layer(0, 0, LAYER_CONTROLLERS, o_sound_controller);
	if (!instance_exists(o_game))
		instance_create_layer(0, 0, LAYER_CONTROLLERS, o_game);
	if (!instance_exists(o_camera)) 
		instance_create_layer(0, 0, LAYER_CONTROLLERS, o_camera);
	if (!instance_exists(obj_fader))
		instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_fader);
		
	// non-persistants
	instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_input_manager);
	instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_options_controller);
	
	with (o_sound_controller) global.camera.subscribe(self);
}

function init()
{
	init_dependencies();
	
	global.sound_controller.play(FMOD_EVENT.MUSIC_MAIN_MENU);
	
	window_set_fullscreen(global.options_controller.options.fullscreen);
	
	root_menu = new MenuNode("");
	
	if (!global.options_controller.get_option(OPTIONS_IS_NEW_GAME))
	{
		root_menu.add_child(new MenuButton("CONTINUAR", function () 
		{
			global.options_controller.unregister_listener(self);
			
			global.sound_controller.stop(FMOD_EVENT.MUSIC_MAIN_MENU);
			global.sound_controller.play(FMOD_EVENT.MENU_NEWGAME_LOADGAME);
			
			var _last_room = global.options_controller.get_option(OPTIONS_LAST_ROOM);
			var _spawn_x = global.options_controller.get_option(OPTIONS_SPAWN_X);
			var _spawn_y = global.options_controller.get_option(OPTIONS_SPAWN_Y);
			
			global.fader.to_room(
				_last_room,
				_spawn_x,
				_spawn_y
			);
		}));
	} else {
		starting_y += 15;
	}
	
	root_menu.add_child(new MenuButton("NOVO JOGO", function() 
	{ 
		global.options_controller.unregister_listener(self);
		
		global.sound_controller.stop(FMOD_EVENT.MUSIC_MAIN_MENU);
		global.sound_controller.play(FMOD_EVENT.MENU_NEWGAME_LOADGAME);
		
		global.options_controller.clear_game_data();
		global.options_controller.set_option(OPTIONS_IS_NEW_GAME, false);
		
		global.fader.to_room(rm_cidade_velha);
	}));
	
	// add_options_button();
	
	root_menu.add_child(new MenuButton("SAIR", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();