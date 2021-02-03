if instance_exists(Container)
{
	alarm[0] = 1;
	exit;
}
if (Items[0] == noone) instance_destroy(id);

