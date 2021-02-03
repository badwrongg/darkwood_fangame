#macro VIEW view_camera[0]
#macro VIEW_WIDTH 2400
#macro GUI_WIDTH  1920
#macro ZOOM_MIN 0.4
#macro ZOOM_MAX 4
#macro ZOOM_SPEED 0.1

function CameraView(_x, _y, _followObject) constructor
{	
	X            = _x;
	Y            = _y;
	RatioWidth   = display_get_height()/display_get_width();
	Follow       = noone;
	FollowObject = _followObject;
	Zoom         = 1;
	ZoomTarget   = 1;
	
	function UpdateFollow()
	{
		if !instance_exists(Follow)
		{
			Follow = instance_nearest(X, Y, FollowObject);
			return;
		}

		X = Follow.x;
		Y = Follow.y;
	}
	
	function SetCamera()
	{	
		ZoomTarget = clamp(ZoomTarget + MOUSE_WHEEL * ZOOM_SPEED, ZOOM_MIN, ZOOM_MAX);
		Zoom = abs(Zoom - ZoomTarget) < 0.01 ? ZoomTarget : lerp(Zoom, ZoomTarget, 0.4);

		var _width = min(VIEW_WIDTH * Zoom, room_width) >> 0;
		if (_width & 1) _width++;
		var _height = _width * RatioWidth;

		var _widthHalf = _width/2;
		var _heightHalf = _height/2;

		X = clamp(X, _widthHalf,  room_width - _widthHalf);
		Y = clamp(Y, _heightHalf, room_height - _heightHalf);

		camera_set_view_size(VIEW, _width, _height);
		camera_set_view_pos(VIEW, X - _widthHalf, Y - _heightHalf);
	}
		
	function SetPosition(_x, _y)
	{
		X = _x;
		Y = _y;
		SetCamera();
	}
	
	function RoomStart()
	{
		view_enabled    = true;
		view_visible[0] = true;
				
		Follow = instance_nearest(X, Y, FollowObject);
		UpdateFollow();
		SetCamera();
	}
	
	function ResetView()
	{
		X = global.StartX;
		Y = global.StartY;
		Follow = noone;
	}	
}

function CameraInitDisplay(_fullscreen)
{
	var _width  = display_get_width();
	var _height = display_get_height()
	var _ratio  = _height/_width;
	
	window_set_fullscreen(_fullscreen);
	window_set_size(_width, _height);
	display_set_gui_size(GUI_WIDTH, GUI_WIDTH * _ratio);
	surface_resize(application_surface, _width, _height);
	
	camera_destroy(VIEW);
	var _cam = camera_create();
	view_set_camera(0, _cam);	
	
	return new CameraView(room_width/2, room_height/2, CHR_Player);
}