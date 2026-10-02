extends HBoxContainer

var selected_slot = null

var player: Player

func setup(player_reference):
	player = player_reference
	#print(player)
	#print("items_hotbar setup called")
	select_slot(0)

func _unhandled_input(event):
	if event.is_action_pressed("select_item_1"):
		select_slot(0)
	elif event.is_action_pressed("select_item_2"):
		select_slot(1)
	elif event.is_action_pressed("select_item_3"):
		select_slot(2)
	elif event.is_action_pressed("select_item_4"):
		select_slot(3)


func select_slot(index):
	var slots = get_children()

	if index >= slots.size():
		return

	if selected_slot:
		selected_slot.set_selected(false)

	selected_slot = slots[index]
	selected_slot.set_selected(true)
	
	# 装备
	#print(player != null)
	player.equip_weapon(selected_slot.item_scene)
