instance_create_layer(x, y, "INSTANCES", CHR_Player);
instance_create_layer(x, y, "EFFECTS", SYS_LightRender);

global.StartX = x;
global.StartY = y;
global.View.SetPosition(x, y);
global.WorldLoaded = true;

instance_destroy(id);