extends CharacterBody2D

@export var TILE_SIZE = 16
@export var walk_speed = 50.0

var lineEditFocused = false

@onready var ray = $RayCast2D 

var initial_position = position
var input_direction = Vector2.ZERO
var last_input_direction = Vector2.ZERO
var is_moving = false
var percent_moved_to_next_tile = 0.0

@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	if not lineEditFocused:
		process_player_movement_input()
		if input_direction != Vector2.ZERO:
			last_input_direction = input_direction
			move(delta)

func process_player_movement_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
		if Input.is_action_pressed("right"):
			animation.play("right")
		elif Input.is_action_pressed("left"):
			animation.play("left")
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
		if Input.is_action_pressed("up"):
			animation.play("up")
		elif Input.is_action_pressed("down"):
			animation.play("down")
		
func move(delta):
	velocity = input_direction * walk_speed
	move_and_slide()

func _on_line_edit_focus_entered():
	lineEditFocused = true

func _on_line_edit_focus_exited():
	lineEditFocused = false


func _on_line_edit_text_submitted(new_text):
	var desired_step: Vector2 = last_input_direction * TILE_SIZE
	ray.target_position = desired_step
	ray.force_raycast_update()
	if ray.is_colliding():
		print(ray.get_collider().interact(new_text))

