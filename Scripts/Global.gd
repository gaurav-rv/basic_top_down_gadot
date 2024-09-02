extends Node

var inventory = []
signal  inventory_updated
var player_node: Node = null
var player_in_range = false

func _ready() -> void:
	inventory.resize(30)
	

func add_item(item) -> bool:
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			return true
	return false
	
func remove_item() -> void:
	inventory_updated.emit()

func increase_inventory_size():
	inventory_updated.emit()
	
func set_player_reference(player):
	player_node = player
