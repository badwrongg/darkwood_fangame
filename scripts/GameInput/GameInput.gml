#macro KEYBOARD 0
#macro GAMEPAD 1
#macro GAMEPAD_EMPTY "- empty -"
#macro GAMEPAD_DISCONNECTED -50
#macro GAMEPAD_DEADZONE 0.25

#macro INPUT_HOR (keyboard_check(vk_right) - keyboard_check(vk_left))
#macro INPUT_VER (keyboard_check(vk_up) - keyboard_check(vk_down))
#macro MOUSE_WHEEL (mouse_wheel_down() - mouse_wheel_up())

function GameInputInit()
{
	var _input = new InputComponent();
	with _input
	{
		PollInputDevices();	
		
		// KEYBOARD
		AddAction(KEYBOARD, "KB ENTER",       vk_space); 
		AddAction(KEYBOARD, "KB CANCEL",      vk_backspace); 
		AddAction(KEYBOARD, "KB ACTION",      vk_space); 
		AddAction(KEYBOARD, "KB SPRINT",      vk_shift); 
		AddAction(KEYBOARD, "KB FLASHLIGHT",  ord("F")); 
		AddAction(KEYBOARD, "KB INVENTORY",   vk_tab); 
		AddAction(KEYBOARD, "KB PAUSE",       vk_escape);
	
		AddAxis(KEYBOARD, "KB HORIZONTAL", ord("D"), ord("A"));
		AddAxis(KEYBOARD, "KB VERTICAL",   ord("S"), ord("W"));			
	} 
	
	return _input;
}

function GamepadBind( _name, _input) constructor
{
	Name   = _name;
	Button = _input;

	function Pressed(_index) { return gamepad_button_check_pressed(_index, Button); }
	function Held(_index) { return gamepad_button_check(_index, Button); }
	function Released(_index) { return gamepad_button_check_released(_index, Button); }
	function GetName() { return Name; }
	function Rebind(_new) { Button = _new; } 
}

function KeyboardBind(_name, _input) constructor
{
	Name   = _name;
	Key    = _input;
	
	function Pressed() { return keyboard_check_pressed(Key); }
	function Held() { return keyboard_check(Key); }
	function Released() { return keyboard_check_released(Key); }
	function GetName() { return Name; }
	function Rebind(_new) { Key = _new; } 
}

function GamepadAxisStick( _name, _stick) constructor
{
	Name     = _name;
	Stick    = _stick;
	
	function GetAxis(_index) 
	{ 
		var _val = gamepad_axis_value(_index, Stick);
		return (abs(_val) > GAMEPAD_DEADZONE) ? _val : 0 ;
	}
	function GetName() { return Name; }
	function Rebind(_stick) { Stick = _stick; } 
}

function GamepadAxisPad(_name, _negative, _positive) constructor
{
	Name     = _name;
	Negative = _negative;
	Positive = _positive;
	
	function GetAxis(_index) { return gamepad_button_check(_index, Negative) - gamepad_button_check(_index, Positive); }
	function GetName() { return Name; }
	function Rebind(_neg, _pos) { Negative = _neg; Positive = _pos; }
	function RebindNegative(_neg) { Negative = _neg; } 
	function RebindPositive(_pos) { Positive = _pos; }
}

function KeyboardAxis(_name, _negative, _positive) constructor
{
	Name     = _name;
	Negative = _negative;
	Positive = _positive;
	
	function GetAxis() { return keyboard_check(Negative) - keyboard_check(Positive); }
	function GetName() { return Name; }
	function Rebind(_neg, _pos) { Negative = _neg; Positive = _pos; }
	function RebindNegative(_neg) { Negative = _neg; } 
	function RebindPositive(_pos) { Positive = _pos; }
}

function InputComponent() constructor
{
	GPCount  = 0;
	GPNames  = array_create(12, "- empty -");
	GPIndex  = GAMEPAD_DISCONNECTED;
	Binds    = DsMapCreateClean();
	
	function AddAction(_device, _name, _input)
	{
		if (_device == GAMEPAD) 
		{
			var _newBind = new GamepadBind(_name, _input);	
		}
		else
		{
			var _newBind = new KeyboardBind(_name, _input);
		}
		ds_map_add(Binds, _name, _newBind);
	}
	
	function AddAxis(_device, _name, _value1, _value2)
	{
		if (_device == GAMEPAD) 
		{
			if is_undefined(_value2) 
			{
				var _newAxis = new GamepadAxisStick(_name, _value1)
			}
			else
			{
				var _newAxis = new GamepadAxisPad(_name, _value1, _value2);	
			}
		}
		else
		{
			var _newAxis = new KeyboardAxis(_name, _value1, _value2);
		}
		ds_map_add(Binds, _name, _newAxis);
	}
		
	function GPAnykey() { return GamepadLastbutton(GPIndex); }
		
	function GamepadFindIndex()
	{
		for (var _g = 0; _g < 12; _g++)
		{
			if (GPNames != GAMEPAD_EMPTY)
			{
				GPIndex = _g;
				return;
			}
		}	
	}
	
	function PollInputDevices()
	{
		for (var _g = 0; _g < 12; _g++) {
			if !gamepad_is_connected(_g) continue;
			
			var _desc = gamepad_get_description(_g);
			if GamepadIsValid(_desc)
			{
				GPCount++;
				GPNames[_g] = _desc;
				if (GPIndex == GAMEPAD_DISCONNECTED) GPIndex = _g;
			}
		}
	}
}

function GamepadIsValid(_description)
{
	if (string_pos("3Dconnexion", _description) != 0) return false;
	if (string_pos("SpacePilot", _description)  != 0) return false;
	return true;
}

function GamepadLastbutton(_index)
{
	if (_index == -1) return false;
	
	for (var _key = gp_face1; _key < (gp_axisrv + 1); _key ++) 
	{
		if gamepad_button_check_pressed(_index, _key) return _key;
	}
	return false;
}

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