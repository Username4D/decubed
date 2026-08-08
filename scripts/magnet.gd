extends Area2D

var is_touching_player = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, 72.0):
		$line.add_point(Vector2(cos(i / 72.0 * 2 * PI), sin(i / 72.0 * 2 * PI)) * 256)
		print(Vector2(cos(i / 18.0 * 2 * PI), sin(i / 18.0 * 2 * PI)) * 256)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	$particles.self_modulate.a = move_toward($particles.self_modulate.a, 1 if Input.is_action_pressed("ui_up") and is_touching_player else 0, delta)
	self.gravity = 0 if !(Input.is_action_pressed("ui_up") and is_touching_player) else 1200


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_touching_player = true
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_touching_player = false
