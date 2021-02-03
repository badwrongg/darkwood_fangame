GameState = global.GameState;
Inventory = GameState.Inventory;
Backpack  = Inventory.Backpack;
Equipped  = Inventory.Equipped;

Mode = ECursorMode.Gameplay;

GUIX = 0;
GUIY = 0;

Tooltip = noone;

ItemHeld = noone;

enum ECursorMode
{
	Menu,
	Gameplay,
	Inventory,
	Looting,
	Trader,
	NoInteraction
}

function CursorMenu()
{
	
}

function CursorGameplay()
{
	var _interact = instance_place(x, y, INT_Interact);
	if (_interact != noone) Tooltip = _interact.Activate(GUIX, GUIY);
}

function CursorInventory()
{
	var _inv = instance_place(GUIX, GUIY, GUI_Inventory);
	if (_inv != noone) image_index = 1;
}

function CursorLooting()
{
	if (CHR_Player.Velocity.Speed != 0) 
	{
		instance_destroy(GUI_ContainerSlots);
		Mode = ECursorMode.Gameplay;
		if (ItemHeld != noone) ItemHeld.Drop();
		return;	
	}
	var _loot = instance_place(GUIX, GUIY, GUI_ContainerSlots);
	if (_loot != noone)
	{
		if mouse_check_button_pressed(mb_left)
			_loot.LootItem(GUIX, GUIY);
		else _loot.ShowItem(GUIX, GUIY);
	}
}

function CursorTrader()
{
	
}