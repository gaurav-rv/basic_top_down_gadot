@tool
extends Node2D

@export var item_type = ""
@export var item_name = ""
@export var item_texture: Texture
@export var item_effect = ""
@export var quantity = 1
var scene_path = "res://Levels/inventory_item.tscn"
@onready var icon_sprite = $Sprite2D 
var player_in_range = false

func _ready() -> void:
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): 
		icon_sprite.texture = item_texture
		
	if player_in_range && Input.is_action_pressed("ui_inv_add"):
		pickup_item()

func pickup_item():
	var item = {
		quantity : quantity,
		item_type : item_type,
		item_name : item_name,
		item_texture : item_texture,
		item_effect : item_effect,
		"scene_path" : scene_path,
	}
	if Global.player_node:
		Global.add_item(item)
		self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		body.interact_ui.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		body.interact_ui.visible = false
