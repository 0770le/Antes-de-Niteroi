function SoundVisuals()
constructor 
{
	limit = 10;
	sound_visuals = [];

	static draw = function()
	{
		array_foreach(sound_visuals, function (_s1) 
		{
			_s1.draw();
		});
	}

	static step = function()
	{
		if (array_length(sound_visuals) > 0)
		{
			array_foreach(sound_visuals, function (_s1) 
			{
				_s1.timeout -= 1;
			});
	
			while (array_length(sound_visuals) > 0 && sound_visuals[0].timeout <= 0) 
			{
				array_shift(sound_visuals);
			}
		}
	}

	static add = function(_sound_visuals = new SoundVisual(0, 0, 0, 0))
	{
		if (array_length(sound_visuals) == limit) 
		{
			array_shift(sound_visuals);
		}
	
		array_push(sound_visuals, _sound_visuals);
		
		array_sort(sound_visuals, function (_s1, _s2) 
		{
			return _s1.timeout - _s2.timeout;
		});
	}
}

function SoundVisual(_x, _y, _alpha = 1, _timeout = 60) 
constructor 
{
	x				= _x;
	y				= _y;
	alpha			= _alpha;
	timeout			= _timeout;
	initial_timeout = _timeout;
	fading_period	= 10;
	
	static draw = function ()
	{
		var _alpha = get_alpha();
		
		draw_sprite_ext(
			spr_sound_basic_icon, 
			0, 
			x, 
			y,
			1,
			1,
			0,
			c_white,
			_alpha
		);
	}
	
	static get_alpha = function () 
	{
		if (initial_timeout - timeout < fading_period)
		{
			return alpha * ((initial_timeout - timeout) / fading_period);
		}
		else if (fading_period > timeout)
		{
			return alpha * (timeout / fading_period);
		}
		else 
		{
			return alpha;
		}
	}
}
