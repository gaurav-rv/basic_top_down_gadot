extends CharacterBody2D

@export var move_speed : float = 100 
@export var starting_direction : Vector2 = Vector2(0,1)
# parameters/Idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var interact_ui = $InteractUi

func _ready() -> void:
	Global.set_player_reference(self)
	update_animation_parameters(starting_direction)

func _physics_process(delta: float):
	# Get input direction 
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
		
	# Update velocity
	velocity = input_direction * move_speed 
	# Move and slide 
	move_and_slide()
	pick_new_state()
	
func update_animation_parameters(move_input: Vector2): 
	if(move_input != Vector2.ZERO):
		print(move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
