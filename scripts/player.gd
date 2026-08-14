extends CharacterBody2D

@export var max_speed = 300
@export var jump_strength = 300
@export var acceleration = 180
@export var friction = 300
@export var speed = 0
@export var max_finish_speed = 1
@export var finish_acceleration = 2
@export var finish_speed = 0

enum states {ALIVE, FINISHED, DEAD}
@export var state = states.ALIVE

@export var spawn_point = Vector2.ZERO
var finish_position = Vector2.ZERO
signal death
signal finished
signal respawn

func _physics_process(delta: float) -> void:
	if state == states.ALIVE:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction == 0:
			speed = move_toward(speed, 0, delta * friction)
		elif speed == 0:
			speed = move_toward(speed, direction * max_speed, delta * acceleration)
		elif direction / abs(direction) != speed / abs(speed):
			speed = move_toward(speed, direction * max_speed, delta * friction)
		else:
			speed = move_toward(speed, direction * max_speed, delta * acceleration)
		
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y -= jump_strength
		
		velocity.x = speed
		velocity.y += get_gravity().y * delta
		move_and_slide()
	if state == states.FINISHED:
		finish_speed = move_toward(finish_speed, max_finish_speed, delta * finish_acceleration)
		self.position = self.position.move_toward(finish_position, finish_speed)
		self.scale = clamp(self.scale.move_toward(Vector2(self.position.distance_to(finish_position) / 64, self.position.distance_to(finish_position) / 64), delta), Vector2(0, 0), Vector2(1, 1))
		self.modulate.a = clamp(move_toward(self.modulate.a, self.position.distance_to(finish_position) / 64, delta), 0, 1)
		self.rotation_degrees += delta * finish_speed * 60
func kill():
	if state == states.ALIVE:
		speed = 0
		velocity = Vector2.ZERO
		death.emit()
		state = states.DEAD
		$animations.play("death")
		await get_tree().create_timer(1.4).timeout
		self.position = spawn_point
		respawn.emit()
		$animations.play_backwards("death")
		state = states.ALIVE

func finish(finish_object: Node):
	if state == states.ALIVE:
		finished.emit()
		finish_position = finish_object.position
		state = states.FINISHED
		speed = 0
