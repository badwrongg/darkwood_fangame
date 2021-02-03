event_inherited();

#macro BOX_AREA 16384
#macro BOX_SPEED 200

PushX = 0;
PushY = 0;
Mass  = sprite_width * sprite_height;
PushSpdMax = clamp(BOX_AREA / Mass * BOX_SPEED, 30, BOX_SPEED);
PushSpd = 0;
Mass = (Mass/100) >> 0;

function PushBox(_x, _y)
{
	if (alarm[0] > 0) return;

	PushSpd = min(PushSpd + 20, PushSpdMax);
	var _dir = arctan2(y - _y, x - _x);
	var _spd = PushSpd * TICK ;
	PushX = cos(_dir);
	PushY = sin(_dir);
	x += PushX * _spd;
	y += PushY * _spd;
	Collider.SetPosition(x, y);

	var _list = ds_list_create();
	var _count = instance_place_list(x, y, COL_Collision, _list, false);	
	for (var _i = 0; _i < _count; _i++) CollisionStaticDIAGS(id, _list[| _i]);
	ds_list_destroy(_list);

	alarm[0] = 1;
}

