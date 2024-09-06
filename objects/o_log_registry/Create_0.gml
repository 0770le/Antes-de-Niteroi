/// @descr


log_by_type = ds_map_create();

function get_log_by_type(_log_type= LOG_TYPE.ARARA){
	return log_by_type[? _log_type];
} 

function get_log_types(){
	return ds_map_keys_to_array(log_by_type,[]);
}

function get_logs() {
	return ds_map_values_to_array(log_by_type,[]);
}



function init() {
	log_by_type[? LOG_TYPE.ARARA]= new LogArara();
	log_by_type[? LOG_TYPE.ARMADEIRA]= new LogArmadeira();
	
}



init();