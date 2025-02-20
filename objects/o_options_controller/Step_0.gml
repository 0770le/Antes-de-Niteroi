var _is_fullscreen = window_get_fullscreen()

if (options.fullscreen != _is_fullscreen)
{
	set_option(OPTIONS_FULLSCREEN, _is_fullscreen);
}