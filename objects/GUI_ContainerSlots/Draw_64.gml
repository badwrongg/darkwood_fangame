if (Container == noone)
{
	instance_destroy(id);
	exit;
}

var _x = x;
var _size = array_length(Container);

for (var _i = 0; _i < _size; _i++)
{
	_x += (_i * INV_SLOT_SIZE);
	draw_sprite(sprite_index, 0, _x, y);  
	if (Container[_i] == noone) continue; 
	Container[_i].DrawIcon(_x, y);
}

if (ItemTooltip < 0 || Container[ItemTooltip] == noone) exit;
Container[ItemTooltip].DrawTooltip(SYS_Cursor.GUIX, SYS_Cursor.GUIY);
ItemTooltip = -1;

if (CHR_Player.Velocity.Speed != 0) instance_destroy(id);