//patrol 
facing = 1;
patrol = false;
patrol_left_limit = x - 3200;
patrol_right_limit = x + 3200;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(14, 16) * room_speed;
wait_time = wait_time_initial;