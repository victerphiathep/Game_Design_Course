extends Node2D

var checkpoint = false
var respawn_position: Vector2

func _ready():
	respawn_position = global_position

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and not checkpoint:
		print("Second Checkpoint Mark")
		$PickedUp.play()
		$Checkpoint_Animation.play("Checkpoint")
		checkpoint = true
		CheckpointManager.set_current_checkpoint(respawn_position)  # Update the manager with the latest checkpoint
