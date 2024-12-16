/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_font(fnt_arial_medium_to_small);

draw_text(bbox_left +10, bbox_top +10, log.name);
draw_text(bbox_left +10, bbox_top +30, log.description);

draw_sprite(log.disclouse_sprite, 0 , x, y);