extends CharacterBody2D

@export var move_speed : float = 100 

func _physics_process(delta: float):
	# Get input direction 
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	print(input_direction)
	
	# Update velocity
	velocity = input_direction * move_speed
	# Move and slide 
	move_and_slide()
