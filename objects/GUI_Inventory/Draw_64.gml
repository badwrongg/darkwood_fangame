var _size = array_length(Backpack);
var _w = _size div INV_HEIGHT;

for (var _i = 0; _i < _size; _i++)
{
	var _x = x + (_i div INV_HEIGHT) * INV_SLOT_SIZE;
	var _y = y + (_i mod INV_HEIGHT) * INV_SLOT_SIZE;
	draw_sprite(sprite_index, 0, _x, _y); 
	
	if (Backpack[_i] == noone) continue; 
	Backpack[_i].DrawIcon(_x, _y);
}
