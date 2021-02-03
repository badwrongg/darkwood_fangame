event_inherited();

var _length = array_length(ItemArray);
Items = array_create(max(ContainerSize, _length), noone);

for (var _i = 0; _i < _length; _i++)
{
	Items[_i] = CreateItem(ItemArray[_i], ItemCount[_i]);
}

function Activate(_x, _y)
{
	if mouse_check_button_pressed(mb_left)
	{
		if !Searched
		{
			Searched = true;
			Name += " (Searched)";
		}
		
		var _slots = instance_create_layer(_x, _y, "GUI", GUI_ContainerSlots);
		_slots.SetContainer(Items);
		return noone;
	} else return id;
}




