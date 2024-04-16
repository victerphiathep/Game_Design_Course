class_name Player extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var Gold = 0

enum States { IDLE, RUNNING, JUMPING, FALLING, ATTACKING }
var current_state = States.IDLE

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _ready():
	var error = anim.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	if error == OK:
		print("Signal connected successfully.")
	else:
		print("Failed to connect signal: ", error)
		
func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")

	handle_movement(direction)
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and current_state != States.ATTACKING:
		current_state = States.JUMPING
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

	if not is_on_floor():
		velocity.y += gravity * delta
		if current_state != States.ATTACKING and current_state != States.JUMPING:
			current_state = States.FALLING

	move_and_slide()

	if is_on_floor():
		if current_state == States.ATTACKING:
			return  # Don't override the attack animation
		elif direction != 0:
			current_state = States.RUNNING
			anim.play("Run")

	handle_attack()

	if Game.currentHealth <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")

func handle_attack():
		if Input.is_action_just_pressed("ui_accept") and current_state != States.ATTACKING:
			current_state = States.ATTACKING
			anim.play("Attack2")

func handle_movement(direction):
	# Air control: Apply horizontal movement even while in air
	velocity.x = direction * SPEED

	# Apply sprite flipping based on direction
	if direction != 0:
		$AnimatedSprite2D.flip_h = direction < 0

	# Animation handling for RUNNING or IDLE states
	if is_on_floor() and current_state not in [States.ATTACKING, States.JUMPING, States.FALLING]:
		if direction != 0:
			current_state = States.RUNNING
			anim.play("Run")
		else:
			velocity.x = 0  # Stop horizontal movement when no input is provided
			current_state = States.IDLE
			anim.play("Idle")

	if current_state == States.FALLING and velocity.y > 0:
		anim.play("Fall")

# Potential use cases for the animation started function are commented out for future implementation.
func _on_animation_player_animation_started(anim_name):
	if anim_name ==  "Attack2":
		print("Attack Started")
		$Attack2_Sound.play()
		
	if anim_name == "Jump":
		print("Jump Started")
		$Jump_Sound.play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack2":
		print("Attack Ended")
		# Directly access the direction here might not reflect the current input state
		# Consider using a more persistent or immediate check for direction if necessary
		var direction = Input.get_axis("ui_left", "ui_right")
		current_state = States.IDLE if direction == 0 else States.RUNNING
	
	if anim_name == "Jump":
		print("Jump Started")
		$Jump_Land.play()
	
	
	


func _on_animated_sprite_2d_animation_finished(anim_name):
	pass


func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_2_body_entered(body):
	pass # Replace with function body.
