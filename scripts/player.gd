extends CharacterBody2D

@export var max_speed = 300
@export var jump_strength = 300
@export var acceleration = 180
@export var friction = 300
@export var speed = 0

func _physics_process(delta: float) -> void:
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
