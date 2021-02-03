function RotateTowards(_current, _target, _speed)
{
	var _diff = (((_target - _current + 540) mod 360) - 180);
	return _current + sign(_diff)*min(abs(_diff), abs(_diff*_speed));
}

function Loop(_value, _increment, _max)
{
	return (_max + _value + _increment) mod _max;
}

function Range(_value, _max)
{
	return (_max + _value) mod _max;
}

function Chance(_per)
{
	if (random(100) < _per) return true;
	return false;
}

function DsListRandomValue(_list)
{
	return _list[| irandom(ds_list_size(_list) - 1)];
}

function DsListCreateClean()
{
	var _garbage = global.DsGarbageList;
	var _list = ds_list_create();
	ds_list_insert(_garbage, 0, _list);
	ds_list_mark_as_list(_garbage, 0);
	return _list;
}

function DsMapCreateClean()
{
	var _garbage = global.DsGarbageList;
	var _map = ds_map_create();
	ds_list_insert(_garbage, 0, _map);
	ds_list_mark_as_map(_garbage, 0);
	return _map;
}

function WorldToGuiX(_x)
{
	return (_x - camera_get_view_x(VIEW)) / camera_get_view_width(VIEW) * display_get_gui_width();
}

function WorldToGuiY(_y)
{
	return (_y - camera_get_view_y(VIEW)) / camera_get_view_height(VIEW) * display_get_gui_height();
}

function SpriteGetDiag(_sprite)
{
	return point_distance(0, 0, sprite_get_width(_sprite), sprite_get_height(_sprite));
}

function Log() 
{
	#macro SP " "
	var _msg = "LOG: ", _arg;
	for (var _i = 0; _i < argument_count; _i++)
	{
		_arg = argument[_i];
		if is_string(_arg) { _msg += _arg+" "; continue; }
	    _msg += string(_arg)+" ";
	}  
	show_debug_message(_msg);
}

function RandomXInRoom()
{
	return irandom_range(ROOM_BUFFER, room_width - ROOM_BUFFER);
}

function RandomYInRoom()
{
	return irandom_range(ROOM_BUFFER, room_height - ROOM_BUFFER);
}