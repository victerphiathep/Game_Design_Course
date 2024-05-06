extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	# Check if the body is the player and act accordingly
	if body.is_in_group("Player"):
		body.respawn()  # This assumes the player has a method 'respawn' that handles the logic to teleport to the checkpoint


func _on_hive_collision_hit_body_entered(body):
	pass # Replace with function body.
