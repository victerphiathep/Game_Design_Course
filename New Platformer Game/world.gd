extends Node2D

@onready var pause_menu = $PauseMenu
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true

