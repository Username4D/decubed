extends Node2D


signal transition_midpoint
signal transition_continue
signal transition_finished

var can_show_ad = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(180).timeout.connect(func(): can_show_ad = true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_transition():
	$transition_layer/animation_player.speed_scale = 2 if SettingsHandler.settings["fast_transitions"] else 1
	$transition_layer/transition_rect.rotation = 0
	$transition_layer/transition_rect.visible = true
	$transition_layer/animation_player.play("transition")
	await $transition_layer/animation_player.animation_finished
	if can_show_ad:
		var result = await CrazyGames.Ad.request_ad_async("midgame")
		print(result)
		can_show_ad = false
		get_tree().create_timer(240).timeout.connect(func(): can_show_ad = true)

	transition_midpoint.emit()
	await transition_continue
	$transition_layer/transition_rect.rotation = PI
	$transition_layer/animation_player.play_backwards("transition")
	await $transition_layer/animation_player.animation_finished
	$transition_layer/transition_rect.visible = false

func change_scene_to_file(path: String, clear_nodes: bool = false, emit_continue: bool = false):
	var new_scene = await load(path).instantiate()
	if clear_nodes:
		for i in $content.get_children():
			i.queue_free()
	$content.add_child(new_scene)
	if emit_continue: transition_continue.emit()

func show_transition_out():
	$transition_layer/animation_player.speed_scale = 2 if SettingsHandler.settings["fast_transitions"] else 1
	$transition_layer/transition_rect.visible = true
	$transition_layer/transition_rect.rotation = PI
	$transition_layer/animation_player.play_backwards("transition")
	await $transition_layer/animation_player.animation_finished
	$transition_layer/transition_rect.visible = false
