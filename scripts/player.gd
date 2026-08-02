extends CharacterBody2D

@export var max_speed = 300
@export var jump_strength = 300
@export var acceleration = 180
@export var friction = 300
@export var speed = 0

enum states {ALIVE, FINISHED, DEAD}
@export var state = states.ALIVE

@export var spawn_point = Vector2.ZERO

signal death

func _physics_process(delta: float) -> void:
	if state == states.ALIVE:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction == 0:
			speed = move_toward(speed, 0, delta * friction)
		elif direction / abs(direction) != speed / abs(speed):
			speed = move_toward(speed, direction * max_speed, delta * friction)
		else:
			speed = move_toward(speed, direction * max_speed, delta * acceleration)
		
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y -= jump_strength
		
		velocity.x = speed
		velocity.y += get_gravity().y * delta
		move_and_slide()

func kill():
	state = states.DEAD
	$animations.play("death")
	await get_tree().create_timer(0.7).timeout
	self.position = spawn_point
	$animations.play("RESET")
	state = states.ALIVE
