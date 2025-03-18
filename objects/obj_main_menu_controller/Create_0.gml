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
	draw_title();
	
	draw_menu_items();
}

function init()
{
	instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_input_manager);
	instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_options_controller);
	
	root_menu = new MenuNode("");
	
	if (global.options_controller.get_option(OPTIONS_SPAWN_X) > 0)
	{
		root_menu.add_child(new MenuButton("Continuar", function () 
		{
			var _aux = {
				last_room: global.options_controller.get_option(OPTIONS_LAST_ROOM),		
				spawn_x: global.options_controller.get_option(OPTIONS_SPAWN_X),		
				spawn_y: global.options_controller.get_option(OPTIONS_SPAWN_Y),	
				callback: function ()
				{
					if (!instance_exists(o_player))
					{
						instance_create_layer(0, 0, LAYER_INSTANCES, o_player);
					}					
					
					with(o_player)
					{
						fade_to_room(other.last_room, other.spawn_x, other.spawn_y, 1);
					}
				}
			}
		
			call_later(1, time_source_units_frames, _aux.callback);
		}));
	}
	
	root_menu.add_child(new MenuButton("Novo Jogo", function() 
	{ 
		if (!instance_exists(o_player))
		{
			instance_create_layer(0, 0, LAYER_INSTANCES, o_player);
		}
					
		with(o_player)
		{
			fade_to_room(rm_cidade_velha, 150, 390, 1);
		}
	}));
	
	root_menu.add_child(new MenuButton("Sair do Jogo", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

// init();