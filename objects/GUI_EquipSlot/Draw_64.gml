for (var _i = 0; _i < EQP_SLOTS; _i++)
{	
	var _y = y + (_i*INV_SLOT_SIZE)
	draw_sprite(sprite_index, 0, x, _y);
	if (Slots[_i] != noone) Slots[_i].Draw(x, _y); 
}