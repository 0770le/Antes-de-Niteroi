enum MENU_TYPE 
{
	UNSET, NODE, LEAF, BUTTON, CHECKBOX, SELECTOR, INTEGER, CATALOG, INPUT, TWO_COLUMNS_NODE
}

function MenuItem(_type = MENU_TYPE.UNSET, _title = "MenuItem") 
constructor 
{
	type = _type;
	title = _title;
	parent = self;
	previous = self;
	next = self;
	
	left = self;
	right = self;
}

function MenuNode(_title = "MenuNode", _children = []) 
	: MenuItem(MENU_TYPE.NODE, _title) 
constructor 
{
	children = [];
	
	static add_child = function (_menu_item = new MenuItem()) 
	{
		var _last = array_last(children);
		
		if (_last != undefined) 
		{
			_last.next = _menu_item;
			
			_menu_item.previous = _last;
		}
		
		array_push(children, _menu_item);
		
		_menu_item.parent = self;
		
		return _menu_item;
	}
	
	static add_children = function (_menu_items = []) 
	{
		array_foreach(_menu_items, add_child);
	}
	
	static init = function (_children = [])
	{
		add_children(_children)
	}
	
	init(_children);
}

function MenuTwoColumnsNode(_title = "MenuNode", _children = [], _children_2 = []) 
	: MenuNode(MENU_TYPE.NODE, _children) 
constructor 
{
	title = _title;
	type = MENU_TYPE.TWO_COLUMNS_NODE;
	
	children = [];
	children_2 = [];
	
	static add_child_2 = function (_menu_item = new MenuItem()) 
	{
		var _last = array_last(children_2);
		
		if (_last != undefined) 
		{
			_last.next = _menu_item;
			
			_menu_item.previous = _last;
		}
		
		array_push(children_2, _menu_item);
		
		if (array_length(children) >= array_length(children_2))
		{
			var _reference_index = array_length(children_2) - 1;
			
			var _last_from_children = children[_reference_index];
			var _last_from_children_2 = children_2[_reference_index];
			
			_last_from_children.right = _last_from_children_2;
			_last_from_children_2.left = _last_from_children;
		}
		
		_menu_item.parent = self;
		
		return _menu_item;
	}
	
	static add_children_2 = function (_menu_items = []) 
	{
		array_foreach(_menu_items, add_child_2);
	}
	
	static init = function (_children = [], _children_2 = [])
	{
		add_children(_children)
		add_children_2(_children_2)
	}
	
	init(_children, _children_2);
}

function MenuLeaf(_title = "MenuLeaf", _sprite = noone)
	: MenuItem(MENU_TYPE.LEAF, _title) 
constructor 
{
	sprite = _sprite;
}

function MenuButton(_title = "MenuButton", _on_click = function () {})
	: MenuItem(MENU_TYPE.BUTTON, _title) 
constructor 
{
	on_click = _on_click;
}

function MenuInput(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP, _input_source_type = INPUT_SOURCE_TYPE.GAMEPAD)
	: MenuItem(MENU_TYPE.INPUT, "PlaceHolder") 
constructor 
{
	is_active				= false;
	input_in_game_action    = _input_in_game_action;
	title					= global.input_manager.get_input_in_game_action_name(input_in_game_action);
	input_source_type		= _input_source_type;
	
	static get_sprite = function ()
	{
		if (is_active)
		{
			return spr_gamepad_xbox_choose;
		}
		else 
		{
			return global.input_manager.get_input_in_game_action_sprite(input_in_game_action);
		}
	}
}

function MenuInputGamepad(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP)
	: MenuInput(_input_in_game_action, INPUT_SOURCE_TYPE.GAMEPAD)
constructor 
{
	on_click = function () 
	{
		global.input_manager.start_capture(self);
		
		sprite = spr_gamepad_xbox_choose;
		
		is_active = true;
	}
}

function MenuInputKeyboard(_input_in_game_action = INPUT_IN_GAME_ACTION.JUMP)
	: MenuInput(_input_in_game_action, INPUT_SOURCE_TYPE.KEYBOARD)
constructor 
{	
	static get_sprite = function ()
	{
		if (is_active)
		{
			return spr_keyboard_choose;
		}
		else 
		{
			return global.input_manager.get_input_in_game_action_sprite(input_in_game_action, input_source_type);
		}
	}
	
	on_click = function () 
	{
		global.input_manager.start_capture(self);
		
		sprite = spr_keyboard_choose;
		
		is_active = true;
	}
}

function MenuCatalog(_title = "MenuCatalog", _on_click = function () {})
	: MenuItem(MENU_TYPE.CATALOG, _title) 
constructor 
{
	on_click = _on_click;
}

function MenuSelector(_title = "MenuSelector", _on_left = function () {}, _on_right = function () {})
	: MenuItem(MENU_TYPE.SELECTOR, _title) 
constructor
{
	on_left = _on_left;
	on_right = _on_right;
}

function MenuCheckbox(_title = "MenuCheckbox", _on_click = function () {}) 
	: MenuButton(_title, _on_click)
constructor
{
	type	= MENU_TYPE.CHECKBOX;
	checked = false;
	
	static set_checked = function (_checked = true) 
	{
		checked = _checked;
	}
}

function MenuInteger(_title = "MenuInteger", _on_left = function () {}, _on_right = function () {})
	: MenuSelector(_title, _on_left, _on_right)
constructor 
{
	type		= MENU_TYPE.INTEGER;
	value_min	= 0;
	value_max   = 10;
	value		= value_max;
	
	static set_value = function(_value = 0)
	{
		value = clamp(_value, value_min, value_max);
	}
}
