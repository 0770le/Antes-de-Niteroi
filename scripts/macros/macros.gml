
function macros(){

#macro GAME_W 640
#macro GAME_H 360
	
	
#macro VOID						0
#macro SOLID					1
#macro PLATAFORM				2
#macro DEATH					3
	
//camera
#macro CAMERA_RESET				0
#macro SCREEN_SHAKE_TIME		1
	
//game 
#macro DISPLAY_MSG				0
#macro TILE_SIZE				16
	
//player speeds
#macro PLAYER_MAX_HSP			2.3
#macro PLAYER_WALK_SPEED		0.3
#macro PLAYER_JUMP_SPEED		6
	
//player alarms
#macro EVADING					0
#macro ATTACKING				1 //attack_delay
#macro ALARM_HURTING			2
#macro HIDING					5
#macro SHOOTING					9 //fire_delay
#macro ANIM_PAUSE				10 //paradinha
#macro ONCE						11//runned_once


//o_enemy_parent alarms
#macro CAN_ATTACK				0 //attack delay
	//ATTACKING					1 //anim pause
	//HURT						2 
#macro KNOCKEDBACK				3
#macro SPAWN					4
	//HIDING					5
#macro DESINGAGE				6
#macro CHASING					7
#macro CLIMBING					8
	//SHOOTING					9
	
	//ONCE						11

//chest
//#macro OPEN						0
	
//o_arrow_spawner
#macro FIRE						0
	
//arrow
#macro LAYER_CHANGE				0
	
//Layer controllers
#macro LAYER_CONTROLLERS				"Controllers"
	
//Layers menu
#macro LAYER_GUI						"GUI"
#macro LAYER_GUI_MENU					"GUI_Menu"
#macro LAYER_GUI_MENU_BUTTONS			"GUI_Menu_Buttons"
#macro LAYER_GUI_MENU_WINDOW			"GUI_Menu_Window"

//layer confirmation
#macro LAYER_GUI_CONFIRMATION				"GUI_Confirmation"
#macro LAYER_GUI_CONFIRMATION_BUTTONS		"GUI_Confirmation_Buttons"
#macro LAYER_GUI_CONFIRMATION_WINDOW		"GUI_Confirmation_Window"
	
//layer Log
#macro LAYER_GUI_LOG						"GUI_Log"
#macro LAYER_GUI_LOG_BUTTONS				"GUI_Log_Buttons"
#macro LAYER_GUI_LOG_WINDOW					"GUI_Log_Window"

#macro LAYER_GUI_LOG_ENTRY					"GUI_Log_Entry"
#macro LAYER_GUI_LOG_ENTRY_BUTTONS			"GUI_Log_Entry_Buttons"
#macro LAYER_GUI_LOG_ENTRY_WINDOW			"GUI_Log_Entry_Window"
	
//Layer Biodiversidade
#macro LAYER_GUI_BIODIVERSIDADE				"GUI_Biodiversidade"
#macro LAYER_GUI_BIODIVERSIDADE_BUTTONS		"GUI_Biodiversidade_Buttons"
#macro LAYER_GUI_BIODIVERSIDADE_WINDOW		"GUI_Biodiversidade_Window"

//Layer Catalog
#macro LAYER_GUI_CATALOG					"GUI_Catalog"
#macro LAYER_GUI_CATALOG_BUTTONS			"GUI_Catalog_Buttons"
#macro LAYER_GUI_CATALOG_WINDOW				"GUI_Catalog_Window"


#macro LAYER_MESSAGES				"Messages"

#macro LAYER_GROUND					"Tiles_ground"
#macro LAYER_WATER					"Tiles_water"

#macro LAYER_COLLISION				"Collisions"

#macro LAYER_EFFECTS				"Effects"
#macro LAYER_PROJECTILES			"Projectiles"
#macro LAYER_INSTANCES				"Instances"

#macro LAYER_BACKGROUND_1			"Backgrounds_1"
#macro LAYER_BACKGROUND_2			"Backgrounds_2"
#macro LAYER_BACKGROUND_3			"Backgrounds_3"
#macro LAYER_BACKGROUND_4			"Backgrounds_4"
#macro LAYER_BACKGROUND_5			"Backgrounds_5"
#macro LAYER_BACKGROUND_6			"Backgrounds_6"
#macro LAYER_BACKGROUND_7			"Backgrounds_7"

#macro COLLECTIBLE_ARARA			1
#macro COLLECTIBLE_ARARIBOIA		2
#macro COLLECTIBLE_ARMADEIRA		3
#macro COLLECTIBLE_CIDADE_VELHA		4
#macro COLLECTIBLE_KUNUMIUASU		5
#macro COLLECTIBLE_MORUBIXABA		6
#macro COLLECTIBLE_MUCURANA			7

#macro COLOR_DK_GRAY		make_color_rgb(89,86,82)

#macro TEXT_Y_HEIGHT_1l				1.75
#macro TEXT_Y_HEIGHT_2l				2.5
	
}