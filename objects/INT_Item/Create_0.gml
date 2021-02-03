event_inherited();

Items[0] = CreateItem(ItemIndex, StackCount);
Container = noone;

function Activate(_x, _y)
{
	if mouse_check_button_pressed(mb_left)
	{
		var _slots = instance_create_layer(_x, _y, "GUI", GUI_ContainerSlots);
		_slots.SetContainer(Items);
		Container = _slots;
		alarm[0] = 1;
		return noone;
	} else return id;
}
