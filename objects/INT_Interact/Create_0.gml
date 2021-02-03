function Activate(_x, _y)
{
	return id;
}

function Draw(_x, _y)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	var _h = sprite_get_height(SPR_InteractOptions)/2;
	draw_text(_x, _y - _h, Name);
	draw_sprite(SPR_InteractOptions, ActionIcon, _x, _y);
	draw_set_valign(fa_top);
	draw_text(_x, _y + _h, ActionText);
}