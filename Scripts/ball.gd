extends KinematicBody2D

var speed=300

signal BallOut

signal EXIT

var velocity=Vector2.ZERO

var direction : Vector2 = Vector2(1, -1) 

onready var paddle = get_parent().find_node("Paddle", false, true)

onready var bricks_instance = Global.theBricks.instance()

func _ready():

	position.x= paddle.position.x 
	position.y = paddle.position.y-$sprite.texture.get_height()/2-paddle.get_node("Sprite").texture.get_height()/2

func _process(delta):
	
	var collision = move_and_collide(direction*velocity*delta)
	
	if position.y > get_viewport().size.y:
		position.x= paddle.position.x 
		position.y = paddle.position.y-$sprite.texture.get_height()/2-paddle.get_node("Sprite").texture.get_height()/2
		velocity=Vector2.ZERO
		emit_signal("BallOut")
				
	if collision : 
		direction = direction.bounce(collision.normal)
		var body = collision.collider
		if body.is_in_group("bricks"):
			body.queue_free()
			
			Global.bricksNumber -= 1
			
			if Global.bricksNumber == 0:
				get_parent().get_node("Sounds/BravoSound").play()
				self.set_process(false)
				emit_signal("EXIT", "BRAVO")
			get_parent().get_node("Sounds/CollisionSound").play()
			Global.score += 10
		elif body.is_in_group("paddle"):
			direction = Vector2((position - get_tree().get_nodes_in_group("paddle")[0].position).x*0.025 , -1).normalized()
	
func _start():
	velocity=Vector2(speed, speed)
	
func _follow_paddle():
	position.x= paddle.position.x 

