extends Node2D

var running = false

func _ready():
	$Ball.connect("BallOut", self, "_on_ball_exited")
	$Ball.connect("EXIT", self, "_bye")
	$endTimer.set_one_shot (true)

func _process(delta):
	_display_items()
	if not running:
		$Display.get_node("message").text="space to go"
		if Input.is_action_pressed("go_command"):
			$Display.get_node("message").text=" "
			running=true
			$Ball._start()
		else:
			$Ball._follow_paddle()
			
func _display_items():
	$Display/lives.text="Lives " + str(Global.lives)
	$Display/trials.text="Trials " + str(Global.trials)
	$Display/score.text="Score "+str(Global.score)
	

func _on_ball_exited():
	running=false
	Global.trials -= 1
	if Global.trials == 0:
		Global.lives -= 1
		if Global.lives == 0:
			$Sounds/GameOverSound.play()  
			running=true # disable inputs
			_bye("GAME OVER")
		else:
			Global.trials=3
			Global.score=0
			$Bricks_container.regenerate_bricks()
			get_tree().reload_current_scene()
			$Sounds/TrialsSound.play()

func _bye(msg):
	$endTimer.start()
	$Ball.hide()
	$Display.get_node("message").visible=false
	$Display.get_node("end").text= msg


func _on_endTimer_timeout():
	get_tree().quit()
