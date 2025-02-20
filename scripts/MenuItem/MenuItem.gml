enum MENU_TYPE 
{
	UNSET, NODE, LEAF, BUTTON, CHECKBOX
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
