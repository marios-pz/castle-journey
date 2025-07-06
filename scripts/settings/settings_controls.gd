extends Control

@onready var music_slider = $MusicSlider
@onready var mute_button = $MuteButton
@onready var game_manager = get_node("/root/GameManager")

var is_muted: bool = false
var previous_volume: float = 50.0

func _ready() -> void:
	# Initialize slider with current volume
	if game_manager and game_manager.background_music:
		var current_volume = game_manager.background_music.volume_db
		# Convert from dB to percentage (assuming -80dB to 0dB range)
		var volume_percentage = ((current_volume + 80.0) / 80.0) * 100.0
		music_slider.value = volume_percentage
		previous_volume = volume_percentage

func _on_music_slider_changed(value: float) -> void:
	if game_manager:
		# Convert percentage to dB (-80dB to 0dB)
		var volume_db = ((value / 100.0) * 80.0) - 80.0
		game_manager.set_music_volume(volume_db)
		previous_volume = value
		
		# Update mute button text
		if value > 0:
			is_muted = false
			mute_button.text = "Mute Music"
		else:
			is_muted = true
			mute_button.text = "Unmute Music"

func _on_mute_button_pressed() -> void:
	if game_manager:
		if is_muted:
			# Unmute - restore previous volume
			music_slider.value = previous_volume
			is_muted = false
			mute_button.text = "Mute Music"
		else:
			# Mute - save current volume and set to 0
			previous_volume = music_slider.value
			music_slider.value = 0
			is_muted = true
			mute_button.text = "Unmute Music" 
