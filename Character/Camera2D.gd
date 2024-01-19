extends Camera2D

@onready var lineEdit = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		lineEdit.release_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
