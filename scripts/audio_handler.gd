extends AudioStreamPlayer

var initialized = false

var playback: AudioStreamPlaybackPolyphonic
var streams: Dictionary = {
	"loop_menu": load("res://assets/loop_menu.ogg"),
	"loop_ingame": load("res://assets/loop_ingame.ogg"),
}
var ingame = false
var playing_ad = false
var expected_master_volume = 0

# Called when the node enters the scene tree for the first time.
func init() -> void:
	stream = AudioStreamPolyphonic.new()
	play()
	playback = get_stream_playback()
	var timer = get_tree().create_timer(1)


func _ready() -> void:
	await CrazyGames.is_initialised_async()
	update_settings(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$loop_ingame.volume_linear = move_toward($loop_ingame.volume_linear, 1 if ingame else 0, delta * 1.2)
	AudioServer.set_bus_volume_linear(0, move_toward(AudioServer.get_bus_volume_linear(0), expected_master_volume, delta))
	AudioServer.set_bus_volume_linear(1, SettingsHandler.settings["music_volume"])
	AudioServer.set_bus_volume_linear(2, SettingsHandler.settings["sfx_volume"])
func update_settings(loop: bool):
	var settings = CrazyGames.Game.get_game_settings()
	expected_master_volume = 0 if settings["muteAudio"] or playing_ad else 1
	if loop: get_tree().create_timer(0.2).timeout.connect(func(): update_settings(true))


func _input(event: InputEvent) -> void:
	if initialized: return
	if not event is InputEventMouseMotion:
		initialized = true
		init()
