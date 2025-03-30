enum LOG_LEVEL
{
	TRACE, DEBUG, INFO, WARN, ERROR
}

function Logger () 
constructor 
{
	log_message_map = 
	[
		"TRACE", "DEBUG", "INFO", "WARN", "ERROR"
	]
		
	static trace = function (_message = "") 
	{
		__log(_message, LOG_LEVEL.TRACE);
	}
	
	static debug = function (_message = "") 
	{
		__log(_message, LOG_LEVEL.DEBUG);
	}
	
	static info = function (_message = "") 
	{
		__log(_message, LOG_LEVEL.INFO);
	}
	
	static warn = function (_message = "") 
	{
		__log(_message, LOG_LEVEL.WARN);
	}
	
	static error = function (_message = "") 
	{
		__log(_message, LOG_LEVEL.ERROR);
	}
	
	static __log = function (_message = "", _level = LOG_LEVEL.INFO) 
	{
		if (global.LOG_LEVEL <= _level) 
		{
			show_debug_message($"[{log_message_map[_level]}] {_message}")
		}
	}
}

global.LOG_LEVEL = LOG_LEVEL.INFO;
global.logger = new Logger();
