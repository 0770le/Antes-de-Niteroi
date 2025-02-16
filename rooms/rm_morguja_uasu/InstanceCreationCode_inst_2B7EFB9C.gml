//patrol 
facing = -1;
patrol = true;
patrol_left_limit =5900;
patrol_right_limit = 6710;
patrol_destination = choose(-1,1);

//how long to wait before patrolling
wait_time_initial = random_range(14, 16) * room_speed;
wait_time = wait_time_initial;