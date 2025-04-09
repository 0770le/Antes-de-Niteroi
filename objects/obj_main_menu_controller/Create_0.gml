event_inherited();

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
margin_bottom	= 40;
margin_top		= 40;

function draw_title()
{
	draw_set_color(c_white);
	draw_set_font(fnt_arial_very_large);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	draw_sprite_ext(spr_main_menu_title, 0, width / 2, 150, 2, 2, 0, c_white, 1);

	draw_text(width / 2, 150, "Antes de Niterói");
}

function draw_controller_buttons()
{
	draw_set_color(accent_color);
	draw_set_font(fnt_arial_medium_to_small);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_right);
	
	var _scale = global.input_manager.get_input_sprite_scale();
	
	var _confirm_sprite = global.input_manager.get_menu_action_sprite(INPUT_MENU_ACTION.CONFIRM);
			
	draw_text(right - (sprite_get_width(_confirm_sprite)*_scale) - margin_right - 10, bottom - margin_bottom - 1, "Confirmar");
	draw_sprite_ext(_confirm_sprite, 0, right - margin_right, bottom - margin_bottom - 1, _scale, _scale, 0, c_white, 1.0);
}

function draw_parent()
{
	
}

function draw()
{
	//draw_title();
	
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
}

function init()
{
	init_dependencies();
	
	global.sound_controller.play(FMOD_EVENT.MUSIC_MAIN_MENU);
	
	window_set_fullscreen(global.options_controller.options.fullscreen);
	
	root_menu = new MenuNode("");
	
	if (!global.options_controller.get_option(OPTIONS_IS_NEW_GAME))
	{
		root_menu.add_child(new MenuButton("Continuar", function () 
		{
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
	}
	
	root_menu.add_child(new MenuButton("Novo Jogo", function() 
	{ 
		global.sound_controller.stop(FMOD_EVENT.MUSIC_MAIN_MENU);
		global.sound_controller.play(FMOD_EVENT.MENU_NEWGAME_LOADGAME);
		
		global.options_controller.clear_game_data();
		global.options_controller.set_option(OPTIONS_IS_NEW_GAME, false);
		
		global.fader.to_room(rm_cidade_velha);
	}));
	
	root_menu.add_child(new MenuButton("Sair do Jogo", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();