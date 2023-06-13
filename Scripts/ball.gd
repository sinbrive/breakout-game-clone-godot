extends KinematicBody2D

var speed=300

var velocity=Vector2.ZERO

var direction : Vector2 = Vector2(1, -1) 

onready var paddle = get_parent().find_node("Paddle", false, true)

onready var bricks_instance = Global.theBricks.instance()

func _ready():
	Global.bricksNumber = bricks_instance.get_child_count() 
#	$timer.connect("timeout", self, "_on_timer_timeout")
	position.x= paddle.position.x 
	position.y = paddle.position.y-$sprite.texture.get_height()/2-paddle.get_node("Sprite").texture.get_height()/2
	
	$endTimer.set_one_shot (true)

func _process(delta):
	
	var collision = move_and_collide(direction*velocity*delta)
	
	if position.y > get_viewport().size.y:
		position.x= paddle.position.x 
		position.y = paddle.position.y-$sprite.texture.get_height()/2-paddle.get_node("Sprite").texture.get_height()/2
		velocity=Vector2.ZERO
		get_parent().running=false
		Global.trials -= 1
		if Global.trials == 0:
			Global.lives -= 1
			if Global.lives == 0:
				$GameOverSound.play()
				_bye("Game Over")
			else:
				Global.trials=3
				Global.score=0
				for child in bricks_instance.get_children():
					child.get_node("Sprite").visible=true
					child.get_node("Sprite").visible=true
					child.get_node("Sprite").visible=true
					child.get_node("Collision_node").disabled=false
					
				get_tree().reload_current_scene()
				Global.bricksNumber = bricks_instance.get_child_count()
				$TrialsSound.play()
				
	if collision : 
		direction = direction.bounce(collision.normal)
		var body = collision.collider
		if body.is_in_group("bricks"):
			body.get_node("Sprite").visible=false
			body.get_node("Collision_node").disabled = true 
			
			Global.bricksNumber -= 1
			if Global.bricksNumber == 0:
				$BravoSound.play()
				_bye("Bravo")

			$CollisionSound.play()
			Global.score += 10
		elif body.is_in_group("paddle"):
			direction = Vector2((position - get_tree().get_nodes_in_group("paddle")[0].position).x*0.025 , -1).normalized()

func _start():
	velocity=Vector2(speed, speed)
	
func _follow_paddle():
	position.x= paddle.position.x 
	position.y = paddle.position.y-$sprite.texture.get_height()/2-paddle.get_node("Sprite").texture.get_height()/2	

func _on_endTimer_timeout():
	get_tree().quit()
	
func _bye(msg):
	$endTimer.start()
	self.hide()
	velocity=Vector2.ZERO
	get_parent().get_node("Display").get_node("message").visible=false
	get_parent().get_node("Display").get_node("win").text= msg
