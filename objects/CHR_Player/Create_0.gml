event_inherited();

Input        = global.Input;
KBAction     = Input.Binds[? "KB ACTION"];
KBSprint     = Input.Binds[? "KB SPRINT"];
KBInventory  = Input.Binds[? "KB INVENTORY"];
KBFlashLight = Input.Binds[? "KB FLASHLIGHT"];
KBHor        = Input.Binds[? "KB HORIZONTAL"];
KBVer        = Input.Binds[? "KB VERTICAL"];

Flashlight = instance_create_layer(x, y, "EFFECTS", LGT_Flashlight);

State = 
{
	CanChange : true,
	CanMove   : true,
	
	Set : function(_change, _move)
	{
		CanChange = _change;
		CanMove   = _move;
	}
}

function EventTick(_tick)
{
	if KBFlashLight.Pressed() Flashlight.ToggleLight();

	ActionState(_tick);

	if State.CanChange
	{
			
	}

	if State.CanMove
	{
		var _hor = KBHor.GetAxis();
		var _ver = KBVer.GetAxis();
		
		if KBSprint.Held() 
		{
			Velocity.Modifier = SprintModifier;
			image_angle = RotateTowards(image_angle, VectorAngle(_hor, _ver), 0.1);		
		} else image_angle = RotateTowards(image_angle, point_direction(x, y, mouse_x, mouse_y), 0.1);
		
		Velocity.RecieveInput(_hor, _ver);
		Velocity.Update(_tick);
		CharacterMove(Velocity.X, Velocity.Y);
				
		if (Velocity.Speed > 0)
			sprite_index = KBSprint.Held() ? SPR_PlayerRunning : SPR_PlayerWalking;
		else sprite_index = SPR_PlayerIdle;
	}
	
	// Counters and things to always set
	Flashlight.SetLocation(x, y, image_angle);
}

function ActionFree(_tick)
{
	if (_tick == ACTION_ENTER)
	{
		State.Set(true, true);
		ActionState = ActionFree;
		sprite_index = SPR_PlayerIdle;
		return;
	}
	
	if KBInventory.Pressed() 
	{ 
		ActionInventory(ACTION_ENTER);	
		return;
	}
}

function ActionLocked(_tick)
{
	if (_tick == ACTION_ENTER)
	{
		State.Set(false, false);
		ActionState = ActionLocked;
		return;
	}
	// This action stays until something else removes it	
}

function ActionInventory(_tick)
{
	if (_tick == ACTION_ENTER)
	{
		State.Set(false, false);
		ActionState   = ActionInventory;
		ActionStep    = EAction.Enter;
		sprite_index  = SPR_PlayerPackOpen;
		image_index   = 0;
		image_speed   = 1;
		SYS_Cursor.Mode = ECursorMode.Inventory;
		return;
	}
	
	switch ActionStep
	{
		case EAction.Enter:
			if ANIM_END 
			{
				ActionStep = EAction.Wait;
				sprite_index = SPR_PlayerPackBrowse;
				GUI_Inventory.visible = true;
			}
			break;
			
		case EAction.Wait:
			if (KBHor.GetAxis() != 0 || KBVer.GetAxis() != 0 || KBInventory.Pressed()) 
			{
				ActionStep = EAction.Finish;
				sprite_index  = SPR_PlayerPackClose;
				image_index   = 0;
			}
			break;
			
		case EAction.Finish:
			if ANIM_END
			{
				GUI_Inventory.visible = false;
				SYS_Cursor.Mode = ECursorMode.Gameplay;
				ActionFree(ACTION_ENTER);
			}
			break;
	}
}

#macro ACTION_ENTER -100
ActionState = ActionFree;
ActionStep  = EAction.None;

enum EAction
{
	Enter,
	Wait,
	Main,
	Finish,
	None
}



