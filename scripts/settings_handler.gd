extends Node

var settings = {"music_volume": 0.5, "sfx_volume": 0.5, "particles_enabled": true, "flashes_enabled": true, "fast_transitions": false, "timer_enabled": false}
var unlocked_levels = 1
var timer_passed_time: float = 0
var initialised = false

var has_loaded_once = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await CrazyGames.is_initialised_async()
	initialised = true
	sdk_load()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func sdk_load():
	if !initialised: return
	for i in settings:
		if CrazyGames.Data.data_has_key(i):
			if settings[i] is bool:
				settings[i] = true if "true" == CrazyGames.Data.data_get_item(i) else false
			elif settings[i] is int:
				settings[i] = CrazyGames.Data.data_get_item(i).to_int()
			elif settings[i] is float:
				settings[i] = CrazyGames.Data.data_get_item(i).to_float()
			else:
				print("original value is ", settings[i], settings[i] is bool)
				settings[i] = CrazyGames.Data.data_get_item(i)
	if CrazyGames.Data.data_has_key("unlocked_levels"):
		unlocked_levels = CrazyGames.Data.data_get_item("unlocked_levels").to_int()
	if CrazyGames.Data.data_has_key("timer_passed_time"):
		timer_passed_time = CrazyGames.Data.data_get_item("timer_passed_time").to_float()
	has_loaded_once = true
	print(settings, unlocked_levels)

func sdk_save():
	if !initialised or !has_loaded_once: return
	for i in settings:
		CrazyGames.Data.data_set_item(i, str(settings[i]))
	CrazyGames.Data.data_set_item("unlocked_levels", str(unlocked_levels))
	CrazyGames.Data.data_set_item("timer_passed_time", str(timer_passed_time))
func has_loaded():
	while !has_loaded_once:
		await get_tree().process_frame
	return
