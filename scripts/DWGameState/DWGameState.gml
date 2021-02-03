function DWGameState() constructor
{
	GameVersion = "0.0.0.1";
	
	Settings = 
	{

	}
	
	Inventory = new PlayerInventory();
	PlayerStats = new PlayerStatComponent(100, 100);
	
}