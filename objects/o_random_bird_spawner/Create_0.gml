/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

spd = random_range(3,4);
range = random_range(55,65); //distance before take off

idle_sprite = s_arara_azul_idle;
flying_sprite = s_arara_azul_flying;

sound = undefined;
flying_sound = undefined;

type_picked = false;
bird_type = 0;

//calll later
function set_bird_type(_bird_type = bird_type){
	switch (_bird_type)
	{
	    case 0: // Arara Azul
	        idle_sprite = s_arara_azul_idle;
	        flying_sprite = s_arara_azul_flying;
	        break;

	    case 1: // Arara Canindé 
	        idle_sprite = s_arara_caninde_idle;
	        flying_sprite = s_arara_caninde_flying;
	        break;

	    case 2: // Arara Vermelha 
	        idle_sprite = s_arara_vermelha_idle;
	        flying_sprite = s_arara_vermelha_flying;
	        break;
			
	    case 3: // Tucano bico preto 
	        idle_sprite = s_tucano_bico_preto_idle;
	        flying_sprite = s_tucano_bico_preto_flying;
	        break;
			
	    case 4: // tucano bico verde
	        idle_sprite = s_tucano_bico_verde_idle;
	        flying_sprite = s_tucano_bico_verde_flying;
	        break;
			
	    case 5: // tucano bico grande
	        idle_sprite = s_tucano_bico_grande_idle;
	        flying_sprite = s_tucano_bico_grande_flying;
	        break;

	    default: // Caso o bird_type não corresponda a nenhum dos casos
	        idle_sprite = s_arara_azul_idle; 
	        flying_sprite = s_arara_azul_flying;
	        break;
	}
	type_picked = true;
}		