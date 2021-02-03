switch InitStep 
{
	case Init.Begin:
		global.DsGarbageList = ds_list_create();
		global.Timers = DsListCreateClean();
		global.Input = GameInputInit();
		global.Pause  = false;
		global.WorldLoaded = false;
		global.StartX = 0;
		global.StartY = 0;
		randomize();
		InitStep++;
		break;
		
	case Init.Display:
		global.View = CameraInitDisplay(true);
		global.Lighting = instance_create_depth(0, 0, 0, SYS_LightEngine);
		InitStep++;
		break;
		
	case Init.Game:
		global.GameState = new DWGameState();
		instance_create_depth(x, y, 0, SYS_Cursor);
		InitStep++;
		break;
		
	case Init.System:
		instance_create_depth(0, 0, 0, SYS_Control);
		instance_create_depth(0, 0, 0, SYS_Debug);
		WINDOW_CENTER;
		InitStep++;
		break;
		
	case Init.Finished:
		Log("FINISHED LOADING");
		room_goto(RM_World);
		break;
}