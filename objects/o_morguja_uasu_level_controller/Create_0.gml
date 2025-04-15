/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

disable_sun = 0;
sun_disabled = false;

sun_x = 0;
sun_y = 0;

sun_alpha = 0.3;

var lay_id = layer_get_id("Backgrounds_sun");

sun_light_id = layer_background_get_id(lay_id);

alarm[0] = 2;

function layer_sun_shader_start()
{
	gpu_set_blendmode( bm_add );
}

function layer_sun_shader_end()
{
	gpu_set_blendmode( bm_normal );
}


layer_script_begin(lay_id, layer_sun_shader_start);
layer_script_end(lay_id, layer_sun_shader_end);