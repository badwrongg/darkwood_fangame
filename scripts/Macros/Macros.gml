#macro TICK delta_time * 0.000001
#macro MICRO_SEC 0.000001
#macro WINDOW_CENTER with SYS_Control alarm[11] = 1

#macro PIRADIAN (180/pi)
#macro RADIAN (pi/180)
#macro EQTRI_HEIGHT_COEFFICIENT (sqrt(3)*0.5)
#macro EQTRI_DTAN_30            (dtan(30))
#macro COF_FRICTION 0.13
#macro COF_DRAG 0.3

#macro FOREVER -50
#macro END_DELEGATE } }
#macro DELEGATE {
#macro EXECUTE Execute : function() {
	
#macro STATE_ENTER 0
#macro STATE_STEP  1
#macro STATE_EXIT  2

#macro MOVE_GROUND 0
#macro MOVE_FLY 1
#macro MOVE_AVOID 2
#macro TERMINAL_V 16
#macro COLLISION_AVOID 6

#macro ROOM_BUFFER (64*20)

#macro TX var _textH = string_height("H") var _textX = 
#macro TY var _textY = 
#macro TEXT draw_text(_textX, _textY, 
#macro ENDLINE ) _textY += _textH
#macro NEWLINE _textY += _textH

#macro ANIM_END  (image_index >= image_number - 1)
#macro ANIM_ENDR (image_index > image_number - 1 || image_index <= 0)