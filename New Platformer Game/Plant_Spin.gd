extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("spin")
	#$Timer.start()  # Ensure the timer starts if not set to Autostart

# This function is called when the Timer node emits the 'timeout' signal.
#func _on_Timer_timeout():
	#$AnimationPlayer.play("spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.respawn()
