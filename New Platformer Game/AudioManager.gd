extends Node

# Dictionary to store references to AudioStreamPlayer nodes
var sound_players = {}

func _ready():
	# Initialize your sound players and add them to the dictionary
	# Ensure you have these nodes as children of the AudioManager node in the scene
	sound_players["jump"] = $Jump_Sound
	sound_players["attack"] = $Attack_Sound
	sound_players["run"] = $Run_Sound

# Function to play a sound by name
func play_sound(sound_name: String):
	if sound_players.has(sound_name) and sound_players[sound_name].stream:
		sound_players[sound_name].play()
	else:
		print("Sound not found or stream not set for:", sound_name)
