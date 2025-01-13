draw_self();

draw_set_font(global.fontSmall);
draw_set_halign(fa_left);
draw_set_color(COLOR_DK_GRAY);

draw_text(bbox_left + 5, bbox_top + 3, displayed_text);

draw_set_halign(fa_center);
draw_set_color(c_white);