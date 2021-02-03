function Timer(_time, _repeat, _precise, _persistent) constructor
{ 
	TimeStart  = _time;
	TimeLeft   = _time;
	Precise    = _precise;
	Finished   = false;
	Repeat     = _repeat;
	Persistent = _persistent;
	Delegates  = array_create(0);
	
	function Update(_tick)
	{
		if Finished return;
		TimeLeft -= _tick;  
		if (TimeLeft > 0) return;
		
		for (var _i = 0; _i < array_length(Delegates); _i++)
		{
			var _delegate = Delegates[_i];
			if is_struct(_delegate) _delegate.Execute();
		}
		
		if (Repeat == FOREVER)
		{
			Restart();
			return;
		}
		
		if (Repeat > 0)
		{
			Repeat--;
			Restart();
			return;
		}
		
		TimeLeft = 0;
		Finished = true;
	}
	
	function Restart()
	{
		TimeLeft = Precise ? TimeLeft + TimeStart : TimeStart;
		Finished = false;
	}
	
	function AddDynamic(_delegate) { array_push(Delegates, _delegate); }
	
	function IsFinished() {	return Finished; }
	
	function SetTime(_time, _restart)
	{
		TimeStart = _time;
		if _restart Restart();
	}
	
	function SetRepeatCount(_count, _restart)
	{
		Repeat = _count;	
		if _restart Restart();
	}
	
	function GetTime() { return TimeLeft; } 
	
	function GetTimePassed() { return (TimeStart - TimeLeft); }
	
	function DrawTime(_x, _y,  _text) { draw_text(_x, _y, _text+string(TimeLeft)); }

	function DrawTimerBar(_sprite, _index, _x, _y, _width) 
	{
		var _w = (_width * (TimeLeft/TimeStart)) / sprite_get_width(_sprite);
		draw_sprite_ext(_sprite, _index, _x, _y, _w, 1, 0, c_white, 1);
	}
}

function DelegateScript(_script, _args) constructor
{
	Script = _script;
	Args   = _args;
	
	function Execute()
	{
		if !is_array(Args) script_execute(Script, Args);
		var _count = array_length(Args);
		switch _count
		{
			case 1: script_execute(Script, Args[0]); break;
			case 2: script_execute(Script, Args[0], Args[1]); break;
			case 3: script_execute(Script, Args[0], Args[1], Args[2]); break;
			case 4: script_execute(Script, Args[0], Args[1], Args[2], Args[3]); break;
			case 5: script_execute(Script, Args[0], Args[1], Args[2], Args[3], Args[4]); break;
		}
	}
}

function TimerListUpdate(_list, _tick)
{
	for (var _i = 0; _i < ds_list_size(_list); _i++)
	{
		var _timer = _list[| _i];
		if is_struct(_timer) 
		{
			with _timer
			{
				Update(_tick);
				if (Finished && !Persistent) ds_list_delete(_list, _i);
			}
			continue;
		}
		
		// Something went wrong, clean it up
		ds_list_delete(_list, _i);
	}
}

function TimerListClean(_list)
{
	for (var _i = 0; _i < ds_list_size(_list); _i++)
	{
		var _timer = _list[| _i];
		if is_struct(_timer) && _timer.Persistent continue;
		ds_list_delete(_list, _i);
	}
}

function GlobalTimerCreate(_time, _repeat, _precise, _persistent)
{
	var _newTimer = new Timer(_time, _repeat, _precise, _persistent);
	ds_list_add(global.Timers, _newTimer);
	return _newTimer;
}