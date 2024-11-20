/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

//DESENHAR HITBOX

draw_set_color(c_teal);
draw_line(bbox_left, bbox_top,bbox_right,bbox_top);
draw_line(bbox_left, bbox_bottom,bbox_right,bbox_bottom);


draw_line(bbox_left, bbox_top,bbox_left,bbox_bottom);
draw_line(bbox_right, bbox_top,bbox_right,bbox_bottom);

//draw_text(x, y - 10, state);