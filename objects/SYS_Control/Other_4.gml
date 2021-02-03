View.RoomStart();

var _inst = layer_get_id("INSTANCES");
if (_inst != -1) layer_add_instance(_inst, id);

if (room != _init) audio_play_sound(BGM_Haunted, 20, true);