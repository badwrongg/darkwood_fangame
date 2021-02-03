
function GamepadAsyncEvent(_input)
{
	var _event = async_load[? "event_type"];

	switch _event {
	
		case "gamepad discovered":
			var _index = async_load[? "pad_index"];
			var _description = gamepad_get_description(_index);
		
			if !GamepadIsValid(_description)
			{
				show_debug_message("Invalid input device: "+_description);
				exit;
			}
		
			
			Log("Slot ", _index, SP, _description, " connected");
			with global.Input
			{
				GPCount++;
				GPNames[_index] = _description;
				GPIndex = _index;
			}

		break;
	
		case "gamepad lost":
		
			var _index = async_load[? "pad_index"];
			with global.Input 
			{
				Log("Slot ", _index, SP, GPNames[_index], " disconnected");
				GPNames[_index] = GAMEPAD_EMPTY;
				GPCount--;
				if (GPIndex == _index) GPIndex = GAMEPAD_DISCONNECTED;
				GamepadFindIndex();
			} 
		break;
	}
}