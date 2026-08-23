extends Node2D

@export var palette_index: int = 0

var checkers_allow_finish = true
var label_position_y = 0
var timer_active = true

@export var timer_enabled = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CrazyGames.Game.gameplay_start()
	AudioHandler.ingame = true
	for i in $checkers.get_children():
		i.update_status.connect(refresh_checkers_status)
	refresh_checkers_status()
	$end_screen.visible = false
	$timer.visible = SettingsHandler.settings["timer_enabled"]
	$player.spawn_point = $spawn_point.position
	await ColorPalettes.load_palette(palette_index)
	$background.visible = true
	$exit_button_texture.self_modulate = ColorPalettes.current_palette.light
	$background_tilemap.self_modulate = ColorPalettes.palettes[palette_index].normal
	$foreground_tilemap.self_modulate = ColorPalettes.palettes[palette_index].very_dark
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$flash.modulate.a = 1 if SettingsHandler.settings["flashes_enabled"] else 0
	$label.position.y = sin(label_position_y) * 8
	label_position_y += delta * 2
	$camera.zoom.y = $camera.zoom.x
	$finish.modulate.a = move_toward($finish.modulate.a, 1 if checkers_allow_finish else 0, delta * 3)
	if timer_active and timer_enabled: SettingsHandler.timer_passed_time += delta
	time_to_string(SettingsHandler.timer_passed_time)
	

func _on_player_finished() -> void:
	timer_active = false
	$animations.play("winscreen_flash")
	if SettingsHandler.unlocked_levels <= int(self.name):
		SettingsHandler.unlocked_levels = int(self.name) + 1
	SettingsHandler.sdk_save()

func _on_player_death() -> void:
	for i in $checkers.get_children():
		i.activated = false
	refresh_checkers_status()
	$animations.play("death_flash")


func _on_menu_button_pressed() -> void:
	AudioHandler.ingame = false
	CrazyGames.Game.gameplay_stop()
	View.show_transition()
	await View.transition_midpoint
	await get_tree().process_frame
	View.change_scene_to_file("res://scenes/level_menu_pages_host.tscn", true, true)
	

func refresh_checkers_status():
	var allow = true
	for i in $checkers.get_children():
		if !i.activated: allow = false
	checkers_allow_finish = allow
	$finish.activated = allow
func _on_next_button_pressed() -> void:
	if ResourceLoader.exists("res://scenes/levels/%d.tscn" % (int(self.name) + 1)):
		View.show_transition()
		await View.transition_midpoint
		await get_tree().process_frame
		View.change_scene_to_file("res://scenes/levels/%d.tscn" % (int(self.name) + 1), true, true)
	else:
		push_error("level not found")

func time_to_string(time: float):
	var milliseconds = roundi((time - floor(time)) * 100)
	var seconds = floori(time) % 60
	var minutes = floori(time / 60)
	var final_string: String = ""
	%minutes.text = str(minutes) if str(minutes).length() != 1 else "0" + str(minutes)
	%seconds.text = str(seconds) if str(seconds).length() != 1 else "0" + str(seconds)
	%milliseconds.text = str(milliseconds) if str(milliseconds).length() != 1 else "0" + str(milliseconds)
	


func _on_exit_button_pressed() -> void:
	CrazyGames.Game.gameplay_stop()
	AudioHandler.ingame = false
	View.show_transition()
	await View.transition_midpoint
	await get_tree().process_frame
	View.change_scene_to_file("res://scenes/level_menu_pages_host.tscn", true, true)
