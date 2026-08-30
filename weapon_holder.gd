extends Node2D

var current_weapon: Node2D

func equip(weapon_scene: PackedScene):
	if (weapon_scene == null):
		return 
	if current_weapon:
		current_weapon.queue_free()
	current_weapon = weapon_scene.instantiate()
	#print("Successfully equipped ", current_weapon.name)
	current_weapon.setup($"..")
	add_child(current_weapon)
	return current_weapon
	

	
