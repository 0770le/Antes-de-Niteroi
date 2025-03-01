enum MENU_TYPE 
{
	UNSET, NODE, LEAF, BUTTON, CHECKBOX, SELECTOR, INTEGER
}

function MenuItem(_type = MENU_TYPE.UNSET, _title = "MenuItem") 
constructor 
{
	type = _type;
	title = _title;
	parent = self;
	previous = self;
	next = self;
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
