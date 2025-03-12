//patrol 
facing = -1;
patrol =false;
patrol_left_limit = x - 10;
patrol_right_limit = x + 10;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(10, 11) * room_speed;
wait_time = wait_time_initial;