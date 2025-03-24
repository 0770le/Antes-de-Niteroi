event_inherited();

possible_enemies = [ENEMY_TYPE.TUPINAMBA_MEELE];

//init variables

hp = 2;
facing = -1; 
die = false;
hurt = false;
right_debris = random_range(1,3);
left_debris = random_range(1,3);
hurt_time = room_speed * 0.5;

on_fire = false;

init();