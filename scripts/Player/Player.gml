function PlayerStatComponent(_health, _energy) constructor
{
		Health      = _health;	
		HealthMax   = _health;
		Energy      = _energy;
		EnergyMax   = _energy;
		Regen = 5;
		Drain = 5;
		
		function HealthAdd(_amount) { Health = min(Health + _amount, HealthMax); }
		function HealthDamage(_amount) 
		{
			Health -= _amount;
			if (Health < 0)
			{
				Health = 0;
				// Do some player death thing
			}
		}
		
		function EnergyAdd(_amount) { Energy = min(Energy + _amount, EnergyMax); } 
		function EnergyRegen() { Energy = min(Energy + Regen, EnergyMax); }
		function EnergyDrain() { Energy = max(Energy - Drain, 0); }
}