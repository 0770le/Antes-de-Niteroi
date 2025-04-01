global.game = self;
//global.timer = 0;

 randomise();

//macros
macros();


//PLAYER upgrades
has_cloak = false;
has_bow = true;

max_lives = 3;
max_arrows =  5;
max_hp = 5;

//has_collectable_nome = false;
collectable_count = 0;


//logs
enum logs {
	LOG_PARENT,		//00
	LOG_ARMADEIRA
}

//create states array
logs_array[logs.LOG_PARENT] = false;
logs_array[logs.LOG_ARMADEIRA] = false;


global.initializer = noone;
global.grav = 0.25;

//volume
global.volume = 0.1;

global.timer = 0;

global.fontSmall = font_add_sprite_ext(spr_font_small, "AÁÀÃÂaáàãâBbCÇcçDdEÉÊeéêFfGgHhIÍiíJjKkLlMmNnOÓÕÔoóõôPpQqRrSsTtUÚuúVvWwXxYyZz1234567890()',.%+-/:?!<>°•", true, 1);
global.fontArrow = font_add_sprite_ext(s_font_arrows, "0123456789", true, 1);
global.fontLives = font_add_sprite_ext(s_font_lives, "0123456789", true, 1);

//set GUI size
display_set_gui_size(640,360);  //(720, 360);


//how many sparks come off gems
gem_sparks = 6;

//how many sparks come off enemies
enemy_sparks = 6;

//game over
//game over and we lost
game_over_lose = false;
//game over and we won
game_over_won = false;

//score delay
game_over_won_delay = room_speed *3;


//main menu
current_frame = 0;

//fade in menu
fade_in = true;
alpha = 1;
fade_spd = 0.02;

//highscore
savename = "game.sav";
highscopre = 0;

//open savefile
ini_open(savename);
//read an old hihgscore , or set it 0 if none
highscore = ini_read_real("Score" , "Highscore", 0);
ini_close();

//final room 
msg = "";

//GAME PROGRESS

quest_saved_kunumiuasu = false;
quest_saved_kunumiuasu_seregipe = false;
quest_saved_kunumiuasu_morguja = false;


//collecibles acquired

collectible[COLLECTIBLE_ARARA] = false;
collectible[COLLECTIBLE_ARARIBOIA] = false;
collectible[COLLECTIBLE_ARMADEIRA] = false;
collectible[COLLECTIBLE_CIDADE_VELHA] = false;
collectible[COLLECTIBLE_KUNUMIUASU] = false;
collectible[COLLECTIBLE_MORUBIXABA] = false;
collectible[COLLECTIBLE_MUCURANA] = false;

//tooltip messages
//msg#, properties
//0 - pre msg
//1 - post msg
//2 - keyboard button
//3 - pad button
//4 - time on screen
//5 - has it been shown this game?

//create grid
global.tooltip = ds_grid_create(5,6);// index0: messages showing, index1: number of properties each message have 

//attack
global.tooltip[# 0,0] = "Press";
global.tooltip[# 0,1] = "to Attack";
global.tooltip[# 0,2] = "E";
global.tooltip[# 0,3] = "B";
global.tooltip[# 0,4] = 3;
global.tooltip[# 0,5] = 0;

//block
global.tooltip[# 1,0] = "Press";
global.tooltip[# 1,1] = "to Block";
global.tooltip[# 1,2] = "Q";
global.tooltip[# 1,3] = "Shoulder Buttons";
global.tooltip[# 1,4] = 3;
global.tooltip[# 1,5] = 0;

//jump
global.tooltip[# 2,0] = "Press";
global.tooltip[# 2,1] = "to Jump";
global.tooltip[# 2,2] = "Space";
global.tooltip[# 2,3] = "A";
global.tooltip[# 2,4] = 3;
global.tooltip[# 2,5] = 0;

//Double Jump
global.tooltip[# 3,0] = "Press";
global.tooltip[# 3,1] = "again to Double Jump";
global.tooltip[# 3,2] = "Space";
global.tooltip[# 3,3] = "A";
global.tooltip[# 3,4] = 3;
global.tooltip[# 3,5] = 0;

//Duck
global.tooltip[# 4,0] = "Press";
global.tooltip[# 4,1] = "to Duck";
global.tooltip[# 4,2] = "Down";
global.tooltip[# 4,3] = "Down";
global.tooltip[# 4,4] = 3;
global.tooltip[# 4,5] = 0;
