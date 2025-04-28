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

should_draw_parent  = false;

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
	
	if (global.i18n.enable)
	{	
		var _change_language_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CHANGE_LANGUAGE);
		draw_text(right - (sprite_get_width(_change_language_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 36, global.i18n.get_message("menu-main-change-language"));
		draw_sprite_ext(_change_language_sprite, 0, right - margin_right, bottom - margin_bottom - 36, _scale, _scale, 0, c_white, 1.0);
	}
		
	var _confirm_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CONFIRM);
	draw_text(right - (sprite_get_width(_confirm_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 1, global.i18n.get_message("main-menu-confirm"));
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
	
	// persistants
	if (!instance_exists(obj_i18n))
		instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_i18n);
}

function init()
{
	init_dependencies();
	
	global.sound_controller.play(FMOD_EVENT.MUSIC_MAIN_MENU);
	
	window_set_fullscreen(global.options_controller.options.fullscreen);
	
	root_menu = new MenuNode("");
	
	if (!global.options_controller.get_option(OPTIONS_IS_NEW_GAME))
	{
		root_menu.add_child(new MenuButton("main-menu-continue", function () 
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
	
	root_menu.add_child(new MenuButton("main-menu-new-game", function() 
	{ 
		global.options_controller.unregister_listener(self);
		
		global.sound_controller.stop(FMOD_EVENT.MUSIC_MAIN_MENU);
		global.sound_controller.play(FMOD_EVENT.MENU_NEWGAME_LOADGAME);
		
		global.options_controller.clear_game_data();
		global.options_controller.set_option(OPTIONS_IS_NEW_GAME, false);
		global.options_controller.clear_unlocks();
		
		global.fader.to_room(rm_cidade_velha);
	}));
	
	root_menu.add_child(new MenuButton("main-menu-quit", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();