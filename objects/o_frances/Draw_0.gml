//draw_text(x,y,hp);
//draw_text(x,y, state);

//flash red when taking damage
if (hurt == true) {
	flash_counter++;
	var flash_on_time = 8; //how long the sprite will stay red
	if (flash_counter < flash_on_time) {
		draw_sprite_ext(sprite_index, image_index, x,y, image_xscale, image_yscale, image_angle, c_maroon, image_alpha);
	} else { 
		draw_self();
		if (flash_counter > flash_on_time * 2) {
			flash_counter = 0;
		}
	}
	
} else {
	draw_self();
}

if(state == frances_states.SHOOT) {
	
	if(image_index > 2 and image_index < 10) {
		draw_set_alpha((image_index/10) - 0.3);
		draw_line_width_color(side()+11*facing, y-20, x + facing * GAME_W, y-20,1, COLOR_YELLOW, COLOR_YELLOW);
		draw_set_alpha(1);
	} else if (floor(image_index) == 10) {
		draw_set_alpha(11-image_index);
		draw_line_color(side()+11*facing, y-20, x + facing * GAME_W, y-20 + random(12)-6, c_white, c_white);	
		draw_set_alpha(1);
	}
}


//DESENHAR HITBOX

//draw_set_color(c_teal);
//draw_line(bbox_left, bbox_top,bbox_right,bbox_top);
//draw_line(bbox_left, bbox_bottom,bbox_right,bbox_bottom);
//draw_line(bbox_left, bbox_top,bbox_left,bbox_bottom);
//draw_line(bbox_right, bbox_top,bbox_right,bbox_bottom);