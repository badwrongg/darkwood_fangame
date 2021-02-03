Container    = noone;
ItemTooltip  = -1;

function SetContainer(_array)
{
	with SYS_Cursor
	{
		if (Mode != ECursorMode.Gameplay) return false;
		Mode = ECursorMode.Looting;
	}
	
	Container = _array;
	image_xscale = array_length(_array);
	var _buffer = INV_SLOT_SIZE * 5;
	x = clamp(x, _buffer, display_get_gui_width() - sprite_width);
	y = clamp(y, _buffer, display_get_gui_height() - sprite_height);	
}

function LootItem(_x, _y)
{
	if (Container == noone) return;	
	_x = (_x - x) div INV_SLOT_SIZE;
	if (_x < 0 || _x >= array_length(Container)) return;
	ArrayAddItem(Container[_x], GameState.Inventory.Backpack);
	Container[@ _x] = noone;
}

function ShowItem(_x, _y)
{
	if (Container == noone) return;	
	_x = (_x - x) div INV_SLOT_SIZE;
	if (_x < 0 || _x >= array_length(Container)) return;
	ItemTooltip = _x;
}
