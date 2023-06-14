extends Node2D

onready var red = preload("res://Assets/element_red_rectangle.png")
onready var yellow = preload("res://Assets/element_yellow_rectangle.png")
onready var green = preload("res://Assets/element_green_rectangle.png")
onready var purple = preload("res://Assets/element_purple_rectangle.png")

func _ready():
	regenerate_bricks()
	Global.bricksNumber = get_child_count() 

func regenerate_bricks():
	var shift=50
	add_line(red, shift+35)
	add_line(purple, shift+70)
	add_line(green, shift+105)
	add_line(yellow, shift+140)

func add_line(bric, shift):
	var st=105
	var brick_scene = preload("res://Scenes/Brick.tscn")
	for i in range(8):
		var b = brick_scene.instance()
		b.get_node("Sprite").set_texture(bric)
		b.get_node("Sprite").scale = Vector2(0.8, 1)
		b.position=Vector2(st+i*(50+5), shift)
		add_child(b)
