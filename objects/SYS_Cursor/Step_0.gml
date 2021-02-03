x = mouse_x;
y = mouse_y;

GUIX = device_mouse_x_to_gui(0);
GUIY = device_mouse_y_to_gui(0);

image_index = 0;

switch Mode
{
	case ECursorMode.Menu:      CursorMenu(); break;
	case ECursorMode.Gameplay:  CursorGameplay();break;
	case ECursorMode.Inventory: CursorInventory(); break;
	case ECursorMode.Looting:   CursorLooting(); break;
	case ECursorMode.Trader:    CursorTrader(); break;
}