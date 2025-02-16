//patrol 
facing = -1;
patrol = true;
patrol_left_limit = 4700;
patrol_right_limit = 5200;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(14, 16) * room_speed;
wait_time = wait_time_initial;