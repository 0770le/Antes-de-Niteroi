//draw_text(x,y,hp);

//draw_circle(x+(facing * 40),y-130, 20, false);

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


//DESENHAR HITBOX

//draw_set_color(c_teal);
//draw_line(bbox_left, bbox_top,bbox_right,bbox_top);
//draw_line(bbox_left, bbox_bottom,bbox_right,bbox_bottom);
//draw_line(bbox_left, bbox_top,bbox_left,bbox_bottom);
//draw_line(bbox_right, bbox_top,bbox_right,bbox_bottom);