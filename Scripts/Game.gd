extends Node2D

var running = false

func _ready():
	pass

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
	
func _win():
	get_tree().quit()

