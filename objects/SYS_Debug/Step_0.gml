if keyboard_check_pressed(vk_f10) room_restart();

if keyboard_check_pressed(vk_f1) 
{
	if DebugOn 
	{
		DebugOn = false;
		show_debug_overlay(false);
	}
	else
	{
		DebugOn = true;
		show_debug_overlay(DebugOverlay);
	}
}

if !DebugOn exit;

if keyboard_check_pressed(ord("H")) GameState.PlayerStats.HealthAdd(10);
if keyboard_check_pressed(ord("J")) GameState.PlayerStats.HealthDamage(10);
if keyboard_check_pressed(ord("N")) GameState.PlayerStats.EnergyDrain();
if keyboard_check_pressed(ord("M")) GameState.PlayerStats.EnergyRegen();
if keyboard_check_pressed(ord("B")) GameState.PlayerStats.EnergyAdd(100);

if keyboard_check_pressed(vk_f5) DrawCollision = !DrawCollision;
if keyboard_check_pressed(vk_f10) 
{
	DebugOverlay = !DebugOverlay;
	show_debug_overlay(DebugOverlay);
}

FPSLow = min(FPSLow, fps_real);