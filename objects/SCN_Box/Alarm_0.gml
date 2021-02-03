PushSpd = min(PushSpd + 60, PushSpdMax);

var _spd = PushSpd * TICK ;
x += PushX * _spd;
y += PushY * _spd;
Collider.SetPosition(x, y);

var _list = ds_list_create();
var _count = instance_place_list(x, y, COL_Collision, _list, false);	
for (var _i = 0; _i < _count; _i++) CollisionStaticDIAGS(id, _list[| _i]);
ds_list_destroy(_list);

alarm[1] = 2;