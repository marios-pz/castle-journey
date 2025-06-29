extends Node2D

var gold: int = 200
var current_level: String = ""
var inventory: Control
var text_bubble: Control
var background_music: AudioStreamPlayer

# Music tracks for different levels
var level_music_tracks = {
	"level_1": "res://assets/music/castle-music-1.mp3",
	"level_2": "res://assets/music/castle-music-1.mp3",  # Same for now, change when you have more music
	"level_3": "res://assets/music/castle-music-1.mp3",  # Same for now, change when you have more music
	"level_4": "res://assets/music/castle-music-1.mp3",  # Same for now, change when you have more music
	"level_5": "res://assets/music/castle-music-1.mp3",  # Same for now, change when you have more music
	"level_item_shop": "res://assets/music/castle-music-1.mp3"  # Same for now, change when you have more music
}

var current_music_track: String = ""

func _process(delta: float) -> void:
	$UiPanel/RichTextLabel.text = "GOLD: " + str(gold)

func _ready() -> void:
	# Initialize references
	inventory = $Inventory
	text_bubble = $TextBubble
	background_music = $BackgroundMusic
	
	# Debug prints
	print("Inventory: ", inventory)
	print("TextBubble: ", text_bubble)
	print("BackgroundMusic: ", background_music)
	
	# Initialize inventory
	if inventory:
		inventory.visible = false
	# Initialize text bubble
	if text_bubble:
		text_bubble.visible = false
	# Setup background music
	setup_background_music()

func setup_background_music() -> void:
	if background_music:
		# Set the music to loop
		background_music.finished.connect(_on_music_finished)
		# Load and start the main menu music
		load_and_play_music("res://assets/music/castle-music-1.mp3")

func _on_music_finished() -> void:
	# Restart the music when it finishes (for looping)
	if background_music:
		background_music.play()

func add_item(item: Item) -> void:
	if inventory:
		inventory.add_item_resource(item)

func show_level_text() -> void:
	if current_level != "" and text_bubble != null:
		print("Showing text for level: ", current_level)  # Debug print
		text_bubble.show_texts(current_level)
	elif text_bubble == null:
		print("Error: TextBubble is null!")
	else:
		print("Error: No current level set!")

func set_current_level(level: String) -> void:
	current_level = level
	print("Current level set to: ", level)  # Debug print
	show_level_text()
	# Change music for the new level
	change_level_music(level)

func change_level_music(level: String) -> void:
	if level_music_tracks.has(level):
		var new_music_path = level_music_tracks[level]
		if new_music_path != current_music_track:
			current_music_track = new_music_path
			load_and_play_music(new_music_path)
			print("Changed music to: ", new_music_path)

func load_and_play_music(music_path: String) -> void:
	if background_music:
		# Stop current music
		background_music.stop()
		
		# Load new music
		var music_stream = load(music_path)
		if music_stream:
			background_music.stream = music_stream
			background_music.play()
			print("Successfully loaded and started music: ", music_path)
		else:
			print("Failed to load music: ", music_path)

# Music control functions
func pause_music() -> void:
	if background_music:
		background_music.stream_paused = true

func resume_music() -> void:
	if background_music:
		background_music.stream_paused = false

func set_music_volume(volume_db: float) -> void:
	if background_music:
		background_music.volume_db = volume_db 
