/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
fmod						= noone;
master_bank_index			= noone;
master_strings_bank_index	= noone;
event_per_enum				= ds_map_create();
vcas_per_enum				= ds_map_create();
busses_per_enum				= ds_map_create();

music_enabled				= true;
sfx_enabled					= true;
music_volume				= 100;
sfx_volume					= 100;

function play(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE)
{
	event_per_enum[? _event_enum].play();
}

function stop(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE)
{
	event_per_enum[? _event_enum].stop();
}

function update_event_parameter(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
								_parameter_name = undefined, 
								_parameter_value = undefined)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
}

function update_event_parameter_and_play(_event_enum = FMOD_EVENT.WEATHER_AMBIENCE, 
										 _parameter_name = undefined, 
										 _parameter_value = undefined)
{
	event_per_enum[? _event_enum].update_parameter(_parameter_name, _parameter_value);
	event_per_enum[? _event_enum].play();
}

function load_fmod()
{
	fmod = instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_fmod);
	
	master_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
	
	master_strings_bank_index = fmod_studio_system_load_bank_file(fmod_path_bundle("sounds/Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
}

function load_events()
{
	#region loops
		
	event_per_enum[? FMOD_EVENT.MUSIC_MENU] = new FmodEvent("event:/MUSIC/music_menu", []);
	event_per_enum[? FMOD_EVENT.MUSIC_GAMEPLAY] = new FmodEvent("event:/MUSIC/music_gameplay", []);
	event_per_enum[? FMOD_EVENT.WEATHER_AMBIENCE] = new FmodEvent(
		"event:/SFX/AMBIENCE_WEATHER/weather_ambience",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_TIME_LAPSE, [FMOD_PARAMETER_TIME_LAPSE.NORMAL, FMOD_PARAMETER_TIME_LAPSE.FASTER, FMOD_PARAMETER_TIME_LAPSE.FASTEST]),
			new FmodParameter(FMOD_PARAMETER_NAME_RAIN, [FMOD_PARAMETER_RAIN.NOT_RAINING, FMOD_PARAMETER_RAIN.RAINING]),
			new FmodParameter(FMOD_PARAMETER_NAME_DAY_NIGHT, [FMOD_PARAMETER_DAY_NIGHT.DAY, FMOD_PARAMETER_DAY_NIGHT.NIGHT]),
			new FmodParameter(FMOD_PARAMETER_NAME_STOP_TIME, [FMOD_PARAMETER_STOP_TIME.NORMAL, FMOD_PARAMETER_STOP_TIME.PAUSED])
		]);
		
	#endregion
	
	#region buttons
	
	event_per_enum[? FMOD_EVENT.CHALLENGE_SHOW] = new FmodEvent("event:/SFX/GAMEPLAY/CHALLENGE/challenge_show");
	event_per_enum[? FMOD_EVENT.NOTIFICATION_CHALLENGE_ANSWER] = new FmodEvent("event:/SFX/GAMEPLAY/CHALLENGE/challenge_awnser");
	
	event_per_enum[? FMOD_EVENT.ACTION_TOOL_PLOW] = new FmodEvent("event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_tool_plow");
	event_per_enum[? FMOD_EVENT.ACTION_TOOL_HARVEST] = new FmodEvent("event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_tool_harvest");
	event_per_enum[? FMOD_EVENT.ACTION_TOOL_PLANT] = new FmodEvent("event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_tool_plant");
	event_per_enum[? FMOD_EVENT.ACTION_TOOL_WATER] = new FmodEvent("event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_tool_water");
	event_per_enum[? FMOD_EVENT.ACTION_TOOL_REMOVE] = new FmodEvent("event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_tool_remove");
	event_per_enum[? FMOD_EVENT.ACTION_TOOL_CLEAN] = new FmodEvent("event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_tool_clean");
	
	event_per_enum[? FMOD_EVENT.ACTION_SELECT_SEED] = new FmodEvent("event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_select_seed");
	event_per_enum[? FMOD_EVENT.ACTION_SELECT_SOIL] = new FmodEvent(
		"event:/SFX/GAMEPLAY/TOOLS/ACTIONS/action_select_soil",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_HOLD_RELEASE_FORBIDDEN, [FMOD_PARAMETER_HOLD_RELEASE_FORBIDDEN.HOLD, FMOD_PARAMETER_HOLD_RELEASE_FORBIDDEN.RELEASE, FMOD_PARAMETER_HOLD_RELEASE_FORBIDDEN.FORBIDDEN]),
		]);
	
	event_per_enum[? FMOD_EVENT.CLICK_BUTTON_TOOLS_AND_CONFIRMATION_DIALOGS] = new FmodEvent(
		"event:/SFX/GAMEPLAY/TOOLS/click_button_tool",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_BUTTON_TOOLS, [FMOD_PARAMETER_BUTTON_TOOLS.SELECT, FMOD_PARAMETER_BUTTON_TOOLS.UNSELECT]),
		]);
	
	event_per_enum[? FMOD_EVENT.HOVER_BUTTON_MENU_INTERNAL] = new FmodEvent("event:/SFX/GAMEPLAY/MENU_INTERNAL/hover_menu_in_gameplay");
	event_per_enum[? FMOD_EVENT.CLICK_BUTTON_INFOS_CHALLENGE_OPTION_AND_INTERNALS] = new FmodEvent(
		"event:/SFX/GAMEPLAY/MENU_INTERNAL/click_button_info",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_OPEN_CLOSE_BASIC, [FMOD_PARAMETER_OPEN_CLOSE_BASIC.OPEN, FMOD_PARAMETER_OPEN_CLOSE_BASIC.CLOSE]),
		]);
		
	event_per_enum[? FMOD_EVENT.CLICK_TAB_CATALOG] = new FmodEvent("event:/SFX/GAMEPLAY/MENU_INTERNAL/click_tab_catalog");
	event_per_enum[? FMOD_EVENT.GAME_EXIT_TO_DESKTOP_OR_START_SCREEN] = new FmodEvent("event:/SFX/GAMEPLAY/MENU_INTERNAL/game_exit_or_home");
	
	event_per_enum[? FMOD_EVENT.NOTIFICATION_QUEST_COMPLETE] = new FmodEvent("event:/SFX/GAMEPLAY/NOTIFICATION/notification_quest_complete");
	event_per_enum[? FMOD_EVENT.NOTIFICATION_GENERAL] = new FmodEvent("event:/SFX/GAMEPLAY/NOTIFICATION/notification_general");
	
	event_per_enum[? FMOD_EVENT.NOTIFICATION_GAME_WIN_OR_LOSE] = new FmodEvent(
		"event:/SFX/GAMEPLAY/NOTIFICATION/notification_ game_win_or_lose",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_WIN_LOSE, [FMOD_PARAMETER_WIN_LOSE.WIN, FMOD_PARAMETER_WIN_LOSE.LOSE]),
		]);
	
	event_per_enum[? FMOD_EVENT.CLICK_BUTTON_TIME_MACHINE] = new FmodEvent(
		"event:/SFX/GAMEPLAY/TIME_MACHINE/click_button_time_machine",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_TIME_MACHINE, [FMOD_PARAMETER_TIME_MACHINE.NORMAL, FMOD_PARAMETER_TIME_MACHINE.FASTER, FMOD_PARAMETER_TIME_MACHINE.FASTEST, FMOD_PARAMETER_TIME_MACHINE.STOP]),
		]);
	
	event_per_enum[? FMOD_EVENT.HOVER_BUTTON_MENU_START_SCREEN] = new FmodEvent("event:/SFX/START_SCREEN/hover_button_start_menu");
	event_per_enum[? FMOD_EVENT.CLICK_BUTTON_MENU_START_SCREEN] = new FmodEvent(
		"event:/SFX/START_SCREEN/click_button_start_menu",
		[
			new FmodParameter(FMOD_PARAMETER_NAME_OPEN_CLOSE_BASIC, [FMOD_PARAMETER_OPEN_CLOSE_BASIC.OPEN, FMOD_PARAMETER_OPEN_CLOSE_BASIC.CLOSE]),
		]);
	
	event_per_enum[? FMOD_EVENT.HOVER_BUTTON_GENERAL] = new FmodEvent("event:/SFX/hover_general");
	
	event_per_enum[? FMOD_EVENT.GAME_NEW_OR_LOAD] = new FmodEvent("event:/SFX/START_SCREEN/game_new_or_load");
}

function load_busses()
{
	busses_per_enum[? FMOD_BUS.MASTER] = fmod_studio_system_get_bus("bus:/");
}

function load_vcas()
{
	vcas_per_enum[? FMOD_VCA.MUSIC]	= fmod_studio_system_get_vca("vca:/MUSIC");
	vcas_per_enum[? FMOD_VCA.SFX]	= fmod_studio_system_get_vca("vca:/SFX");
}

function on_options_change(_options = instance_create_layer(0, 0, LAYER_CONTROLLERS, obj_options_instance))
{
	music_enabled	= _options.music_enabled;
	sfx_enabled		= _options.sfx_enabled;
	music_volume	= _options.music_volume;
	sfx_volume		= _options.sfx_volume;
	master_enabled	= _options.master_enabled;
	master_volume	= _options.master_volume;
	
	fmod_studio_bus_set_volume(busses_per_enum[? FMOD_BUS.MASTER], master_enabled ? (master_volume / 100) : 0);
	
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.MUSIC], music_enabled ? (music_volume / 100) : 0);
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX],   sfx_enabled ?   (sfx_volume   / 100) : 0);
}

function init() 
{
	load_fmod();
	
	load_events();
	
	load_vcas();
	
	load_busses();
	
	//obj_options_controller.register_options_listener(self);
	
	//on_options_change(obj_options_controller.options);
	fmod_studio_bus_set_volume(busses_per_enum[? FMOD_BUS.MASTER], 1);//master_enabled ? (master_volume / 100) : 0);
	
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.MUSIC], 1);// music_enabled ? (music_volume / 100) : 0);
	fmod_studio_vca_set_volume(vcas_per_enum[? FMOD_VCA.SFX],   1);// sfx_enabled ?   (sfx_volume   / 100) : 0);
	
}

init();