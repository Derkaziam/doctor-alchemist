extends Node

signal garbage_clicked(player_id, interactable_id, item)

func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player_interaction")
	for node in players:
		node.connect("player_interacted", _on_player_interacted)

func _on_player_interacted(player_id: int, interactable_id: int, item: Item, element) -> void:
		# if the player isnt holding an item and there is stock of items, emit the crate_opened signal
		if item.item_id != Globals.ItemID.NONE:
			emit_signal("garbage_clicked", player_id, interactable_id, get_node("../Item").duplicate(), get_node("../Item").element)
			
			#update stats!
			if player_id == 0:
				Globals.thrown0 += 1
			elif player_id == 1:
				Globals.thrown1 += 1
			else:
				print("I recieved ", player_id , "As a player id. This should be 1 or 0.")
		
		else: return


func get_crate() -> Area2D:
	var crate = get_parent()
	if is_instance_valid(crate):
		return crate
	else:
		printerr("PlayerInteraction has no valid parent (Player node).")
		return null
