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
	instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_options_controller);
	
	root_menu = new MenuNode("");
	
	var _aux = {
		last_room: global.options_controller.options.last_room,
		last_player_x: global.options_controller.options.last_player_x,
		last_player_y: global.options_controller.options.last_player_y,
		callback: function ()
		{
			room_goto(rm_init);
			
			call_later(1, time_source_units_frames, function () 
			{ 
				room_goto(self.last_room);
			});
			
			call_later(2, time_source_units_frames, function () 
			{
				global.player.x = self.last_player_x;
				global.player.y = self.last_player_y;
			});
		}
	}
	
	root_menu.add_child(new MenuButton("Continuar", _aux.callback));
	
	root_menu.add_child(new MenuButton("Novo Jogo", function() 
	{ 
		room_goto(rm_init);
		
		var _ = call_later(1, time_source_units_frames, function () { room_goto(rm_cidade_velha) });
	}));
	
	root_menu.add_child(new MenuButton("Sair do Jogo", function() 
	{ 
		game_end(0); 
	}));
	
	selected_item = root_menu.children[0];
	
	instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_input_manager);
	
	global.input_manager.subscribe(self, INPUT_TYPE.MENU);
}

init();