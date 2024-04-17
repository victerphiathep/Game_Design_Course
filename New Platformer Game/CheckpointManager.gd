# CheckpointManager.gd (can be autoloaded)
extends Node2D

var current_checkpoint: Vector2

func set_current_checkpoint(position: Vector2):
	current_checkpoint = position

func get_current_checkpoint() -> Vector2:
	return current_checkpoint
