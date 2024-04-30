extends Control

func _ready():
	visible = false
	$AnimationPlayer.play("RESET")


func resume():
	get_tree().paused = false
	visible = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	visible = true
	$AnimationPlayer.play_backwards()

func testEsc():
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed():
	resume()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
