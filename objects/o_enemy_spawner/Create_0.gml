depth += 10;

drop_hp = false;

enum ENEMY_TYPE {
	ARMADEIRA,
	CHEVALIER,
	FRANCES,
	HARPIA,
	IAGUARA,
	JARARACA,
	TUPINAMBA_MEELE,
	TUPINAMBA_RANGED
}

enemy_objects = 
[
	o_armadeira,
	o_chevalier,
	o_frances,
	o_harpia,
	o_iaguara,
	o_jararaca,
	o_tupinamba_melee,
	o_tupinamba
]

patrol_left = 100;
patrol_right = 100;

possible_enemies = [ENEMY_TYPE.TUPINAMBA_MEELE, ENEMY_TYPE.TUPINAMBA_RANGED];
enemy_instances	= [];
max_enemies	= 2;
spawn_interval = 2_000_000; // 1 microsecond is 1,000,000th of a second
should_spawn = true;
last_spawn_attempt = 0;
spawn_radius = 50; // pixels
full_hp = 3;
current_hp = full_hp;
image_speed = 0;

function step()
{
	if (!should_spawn) return;
	
	last_spawn_attempt += delta_time;
	
	if (last_spawn_attempt >= spawn_interval)
	{
		if (array_length(enemy_instances) < max_enemies)
		{
			spawn_enemy();
		}
		else 
		{
			update_enemy_instances();
		}
		
		last_spawn_attempt = 0;
	}
}

function spawn_enemy()
{
	var _object_index = possible_enemies[irandom_range(0, array_length(possible_enemies) - 1)];
			
	var _instance = instance_create_layer(x + irandom_range(-spawn_radius, spawn_radius), y, LAYER_INSTANCES, enemy_objects[_object_index]);
	
	_instance.patrol_left_limit = x - patrol_left;
	_instance.patrol_right_limit = x + patrol_right;
	
	array_push(enemy_instances, _instance);
}

function update_enemy_instances()
{
	for (var _i = 0; _i < array_length(enemy_instances); _i++)
	{
		var _instance = enemy_instances[_i];
		
		if (!instance_exists(_instance))
		{
			array_delete(enemy_instances, _i, 1);
		}
	}
}

function start()
{
	should_spawn = true;
	last_spawn_attempt = 0;
}

function stop()
{
	should_spawn = false;
}

function init()
{
	depth += 1;
	
	start();
}
