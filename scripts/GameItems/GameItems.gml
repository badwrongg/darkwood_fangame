function CreateItem(_itemIndex, _stackCount)
{
	switch _itemIndex
	{
		case EItem.None: return noone;
		
		// Consumable
		case EItem.Bandage:	   return new ItemConsumable("Bandage", _itemIndex, _stackCount); 
		case EItem.Medkit:	   return new ItemConsumable("Medkit", _itemIndex, _stackCount); 
		case EItem.Food:	   return new ItemConsumable("Food", _itemIndex, _stackCount); 
		case EItem.CannedFood: return new ItemConsumable("Canned Food", _itemIndex, _stackCount); 

		// Equipment
		case EItem.Boots:    return new ItemEquipment("Boots", _itemIndex); 
		case EItem.Shoes:    return new ItemEquipment("Shoes", _itemIndex); 
		case EItem.Sneakers: return new ItemEquipment("Sneakers", _itemIndex); 
		case EItem.Pants:    return new ItemEquipment("Pants", _itemIndex); 
		case EItem.Tshirt:   return new ItemEquipment("T-Shirt", _itemIndex); 
		case EItem.Jacket:   return new ItemEquipment("Jacket", _itemIndex); 
		case EItem.Cap:      return new ItemEquipment("Cap", _itemIndex); 

		// Melee
		case EItem.Knife:       return new ItemMelee("Knife", _itemIndex); 
		case EItem.Axe:         return new ItemMelee("Axe", _itemIndex); 
		case EItem.BaseballBat: return new ItemMelee("Baseball Bat", _itemIndex); 
		case EItem.Machete:     return new ItemMelee("Machete", _itemIndex); 

		// Guns
		case EItem.GunPistol:  return new ItemGun("Pistol", _itemIndex); 
		case EItem.GunMP5K:    return new ItemGun("MP5K", _itemIndex); 
		case EItem.GunShotgun: return new ItemGun("Shotgun", _itemIndex); 
		case EItem.GunAK:      return new ItemGun("AK47", _itemIndex); 
		case EItem.GunM4:      return new ItemGun("M4", _itemIndex); 
	}
}

enum EItem 
{
	None,
	Backpack,
	
	// Consumables
	Bandage,
	Medkit,
	Food,
	CannedFood,

	// Equipment
	Boots,
	Shoes,
	Sneakers,
	Pants,
	Tshirt,
	Jacket,
	Cap,

	// Melee
	Knife,
	Axe,
	BaseballBat,
	Machete,

	// Guns
	GunPistol,
	GunMP5K,
	GunShotgun,
	GunAK,
	GunM4,

	// System
	Last	
}

enum EItemType
{
	Consumable,
	Equipment,
	Melee,
	Gun,
	Material,
	Junk,
	Last
}

#macro INV_SIZE 12
#macro INV_HEIGHT 6
#macro INV_SLOT_SIZE (sprite_get_width(sprite_index))
#macro EQP_SLOTS 3

//index = ((my div size) * invWidth + (mx div size))

function PlayerInventory() constructor
{
	Opened   = false;
	Backpack = array_create(INV_SIZE, noone);
	Equipped = array_create(EQP_SLOTS, noone);
	Width = array_length(Backpack) div INV_HEIGHT;
}

function ItemBase(_name, _index, _stack) constructor
{
	Name     = _name;
	Index    = _index;
	Stack    = _stack;
	Type     = EItemType.Last;
	
	function Use(_x, _y)
	{
		Log("No item use.");
		return true;	
	}
	
	function Drop()
	{
		if instance_exists(CHR_Player)
		{
			var _x = CHR_Player.x;
			var _y = CHR_Player.y;
		}
		else
		{
			var _x = mouse_x;
			var _y = mouse_y;
		}
		var _drop = instance_create_layer(_x, _y, "SCENE_BOTTOM", INT_Item);
		_drop.Items[0] = self;
	}
	
	function DrawIcon(_x, _y)
	{
		draw_sprite(SPR_Items, Index, _x, _y);	
	}
	
	function DrawTooltip(_x, _y)
	{
		draw_text(_x, _y, Name);	
	}
}

function ItemConsumable(_name, _index, _stackCount) : ItemBase(_name, _index) constructor
{
	Type = EItemType.Consumable;
	Stack = _stackCount;
}

function ItemEquipment(_name, _index) : ItemBase(_name, _index) constructor
{
	Type = EItemType.Equipment;
}

function ItemMelee(_name, _index) : ItemBase(_name, _index) constructor
{
	Type = EItemType.Melee;
	Durability = 100;
}

function ItemGun(_name, _index) : ItemBase(_name, _index) constructor
{
	Type = EItemType.Gun;
	Durability = 100;
}

function ArrayAddItem(_item, _array)
{
	if (_item == noone) return false;
	var _length = array_length(_array);
	for (var _i = 0; _i < _length; _i++)
	{
		if (_array[_i] == noone) 
		{
			_array[@ _i] = _item;
			return true;
		}
	}
	return false;
}
