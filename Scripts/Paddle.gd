extends KinematicBody2D

const SPEED=350

func _ready():
	self.add_to_group("paddle")
	position.x = get_viewport().size.x/2
	position.y = get_viewport().size.y-30

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	position.x = clamp(get_global_mouse_position().x, 52, get_viewport().size.x-52); 
	position.y = get_viewport().size.y-30
	
#	if (Input.is_action_pressed("move_right")):
#		velocity.x += SPEED
#	if (Input.is_action_pressed("move_left")):
#		velocity.x -= SPEED

	move_and_slide(velocity)
