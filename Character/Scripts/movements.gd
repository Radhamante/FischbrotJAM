extends CharacterBody2D

@export var walk_speed = 4.0
const TILE_SIZE = 16

var initial_position = position
var input_direction = Vector2.ZERO
var is_moving = false
var percent_moved_to_next_tile = 0.0

@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	if is_moving == false:
		animation.play("idle")
		process_player_movement_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false

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
	
	
	if input_direction != Vector2.ZERO:
		initial_position = position
		is_moving = true
		
func move(delta):
	percent_moved_to_next_tile += walk_speed * delta
	if percent_moved_to_next_tile >= 1.0:
		position = initial_position + (input_direction * TILE_SIZE)
		percent_moved_to_next_tile = 0.0
		is_moving = false
	else:
		position = initial_position + (input_direction * TILE_SIZE * percent_moved_to_next_tile)



#@export var MAX_SPEED := 300
#@export var ACCELERATION :=  1500
#@export var FRICTION := 1200
#
#@onready var axis = Vector2.ZERO
#
#func _physics_process(delta):
	#pass
	#
#func get_input_axis():
	#axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	#axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
#
#func move (delta):
	#axis = get_input_axis()
	#if axis == Vector2.ZERO:
		#apply_friction(FRICTION * delta)
	#else:
		#apply_novement (axis * ACCELERATION * delta)
	#move_and_slide()
#
#func apply_friction (amount):
	#if velocity.length() › amount:
		#
