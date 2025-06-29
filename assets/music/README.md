# Castle Journey - Music System

## 🎵 Current Music Files
- `castle-music-1.mp3` - Main theme (currently used for all levels)

## 🎼 How to Add Different Music for Each Level

### Step 1: Add Music Files
Place your music files in this folder:
- `level_1_music.mp3` - Forest theme
- `level_2_music.mp3` - Castle gate theme  
- `level_3_music.mp3` - Town square theme
- `level_4_music.mp3` - Tower theme
- `level_5_music.mp3` - Bridge theme
- `shop_music.mp3` - Shop theme

### Step 2: Update Music Dictionary
In `scripts/game_manager/game_manager.gd`, update the `level_music_tracks` dictionary:

```gdscript
var level_music_tracks = {
	"level_1": "res://assets/music/level_1_music.mp3",
	"level_2": "res://assets/music/level_2_music.mp3", 
	"level_3": "res://assets/music/level_3_music.mp3",
	"level_4": "res://assets/music/level_4_music.mp3",
	"level_5": "res://assets/music/level_5_music.mp3",
	"level_item_shop": "res://assets/music/shop_music.mp3"
}
```

### Step 3: Import in Godot
1. Open Godot Editor
2. Go to FileSystem tab
3. Right-click on new music files
4. Select "Reimport"
5. Wait for import to complete

## 🎯 Current System Features
- ✅ Automatic music change when entering different levels
- ✅ Music loops continuously
- ✅ Volume control in settings
- ✅ Mute/unmute functionality
- ✅ Music pauses when menu is open

## 📝 Supported Formats
- MP3
- OGG
- WAV
- FLAC