function InstanceCreateSwitch(_id, _name, _actionText)
{
	with _id
	{
		var _left   = bbox_left,
			_right  = bbox_right,
			_top    = bbox_top,
			_bot    = bbox_bottom,
			_layer  = layer;
	}
	
	var _switch = instance_create_layer(_left, _top, _layer, INT_Switch);
	with _switch
	{
		Name = _name;
		ActionText = _actionText;
		image_xscale = _right - _left;
		image_yscale = _bot - _top;
		Switch       = _id;
	}
	return _switch;
}

function InstanceNearestNotMe(_object) 
{
    var _realX = x;
	x = x << 5;
    var _nearest = instance_nearest(_realX, y, _object);
	x = _realX;
    if (_nearest == id) return noone;
    return _nearest;
}

function InstanceCreateLayerView(_inside, _buff, _viewIndex, _createObject, _layer, _map, _try)
{
	if is_undefined(_map)
	{
		var _point = GetRandomPointView(_inside, _buff, _viewIndex); 
		with _point return instance_create_layer(X, Y, _layer, _createObject);
	}
	
	// Try for navigable point
	for (var _t = 0; _t < _try; _t++)
	{
		with GetRandomPointView(_inside, _buff, _viewIndex)
		{
			if PointIsNavigable(X, Y, _map) return instance_create_layer(X, Y, _layer, _createObject);
		}
	}
	return noone;
}

function InstanceCreateDepthView(_inside, _buff, _viewIndex, _createObject, _depth, _map, _try)
{
	if is_undefined(_map)
	{
		var _point = GetRandomPointView(_inside, _buff, _viewIndex); 
		with _point return instance_create_depth(X, Y, _depth, _createObject);
	}
	
	for (var _t = 0; _t < _try; _t++)
	{
		with GetRandomPointView(_inside, _buff, _viewIndex)
		{
			if PointIsNavigable(X, Y, _map) return instance_create_depth(X, Y, _depth, _createObject);
		}
	}
	return noone;
}

function InstanceCreateLayerRegion(_inside, _buff, _x, _y, _w, _h, _createObject, _layer, _map, _try)
{
	if is_undefined(_map)
	{
		var _point = GetRandomPointRegion(_inside, _buff, _x, _y, _w, _h); 
		with _point return instance_create_layer(X, Y, _layer, _createObject);
	}
	
	for (var _t = 0; _t < _try; _t++)
	{
		with GetRandomPointRegion(_inside, _buff, _x, _y, _w, _h)
		{
			if PointIsNavigable(X, Y, _map) return instance_create_layer(X, Y, _layer, _createObject);
		}
	}
	return noone;
}

function InstanceCreateDepthRegion(_inside, _buff, _x, _y, _w, _h, _createObject, _depth, _map, _try)
{
	if is_undefined(_map)
	{
		var _point = GetRandomPointRegion(_inside, _buff, _x, _y, _w, _h); 
		with _point return instance_create_depth(X, Y, _depth, _createObject);
	}
	
	for (var _t = 0; _t < _try; _t++)
	{
		with GetRandomPointRegion(_inside, _buff, _x, _y, _w, _h)
		{
			if PointIsNavigable(X, Y, _map) return instance_create_depth(X, Y, _depth, _createObject);
		}
	}
	return noone;
}

function InstanceCreateLayerMouse(_object, _layer, _map)
{
	if is_undefined(_map) return instance_create_layer(mouse_x, mouse_y, _layer, _object);
	
	var _mx = mouse_x;
	var _my = mouse_y;
	if (tilemap_get_at_pixel(_map, _mx, _my) & tile_index_mask == TILE_SOLID) return noone;
	
	return instance_create_layer(_mx, _my, _layer, _object);
}

function InstanceCreateDepthMouse(_object, _depth, _map)
{
	if is_undefined(_map) return instance_create_depth(mouse_x, mouse_y, _depth, _object);
	
	var _mx = mouse_x;
	var _my = mouse_y;
	if (tilemap_get_at_pixel(_map, _mx, _my) & tile_index_mask == TILE_SOLID) return noone;
	
	return instance_create_depth(_mx, _my, _depth, _object);
}