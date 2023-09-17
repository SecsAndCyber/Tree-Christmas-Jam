extends Node2D

var BackgroundMap = preload("res://assets/GameWorldMap.png")
var LilDude = preload("res://assets/LilDude.png")

var input_vector = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$LilDude.transform = $LilDude.transform.translated(input_vector)
	input_vector = Vector2(0,0)

func _unhandled_input(event):
	_input(event)
		
func _input(event):
	if event is InputEvent:
		# Handle key events
		if event.is_action_pressed("ui_accept"):
			print("ui_accept")
			$WorldSpace.texture = BackgroundMap
			$LilDude.texture = LilDude
		elif event.is_action_pressed("ui_cancel"):
			print("ui_cancel")
			get_tree().quit()
			
		if event.is_action("ui_up"):
			input_vector += Vector2(0,-1)
		if event.is_action("ui_down"):
			input_vector += Vector2(0,1)
		if event.is_action("ui_left"):
			input_vector += Vector2(-1,0)
		if event.is_action("ui_right"):
			input_vector += Vector2(1,0)
			
