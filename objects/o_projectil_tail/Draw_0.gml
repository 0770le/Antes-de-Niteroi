//draw line
//set blend mode
gpu_set_blendmode(bm_add);
draw_set_alpha(0.25);
//draw head
draw_set_colour(col_head);
draw_line_width(xp, yp, x, y, min(abs(speed),1) * line_width);
//draw tail
draw_set_colour(col_tail);
draw_line_width(xpp, ypp, xp, yp, min(abs(speed),1) * line_width);

//reset blend mode
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);


//update variables
//update positions
xpp = xp;
ypp = yp;
xp = xprevious;
yp = yprevious;

