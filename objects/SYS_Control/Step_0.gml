if keyboard_check_pressed(vk_escape) game_end();
if keyboard_check_pressed(ord("P")) global.Pause = !global.Pause;
if global.Pause exit;

var _tick = TICK;
TimerListUpdate(TimerList, _tick);
with ACT_Tick EventTick(_tick);

global.FilmGrainSpeed += _tick;

global.FilmGrainStrength = clamp(global.FilmGrainStrength + INPUT_VER, 10, 100); 
global.ambientShadowIntensity = clamp(global.ambientShadowIntensity + INPUT_HOR *0.025, 0.4, 2);

View.UpdateFollow();
View.SetCamera();
