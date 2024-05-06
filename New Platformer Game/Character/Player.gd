extends CharacterBody2D

class_name Player

@export var speed : float = 250.0
@export var Gold = 0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var checkpoint_position: Vector2
var is_running = false  # To track the running state

signal facing_direction_changed(facing_right : bool)

func _ready():
	add_to_group("Player")
	animation_tree.active = true
	checkpoint_position = global_position  # Initialize with starting position

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Control movement based on direction and state machine
	if direction.x != 0 && state_machine.check_if_can_move():
		if not is_running:
			$Run_Sound.play()  # Start playing the run sound
			is_running = true
		velocity.x = direction.x * speed
	else:
		if is_running:
			$Run_Sound.stop()  # Stop the run sound
			is_running = false
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if Game.currentHealth <= 0:
		respawn()  # Respawn if health is zero

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)

func set_checkpoint(position: Vector2):
	checkpoint_position = position

func respawn():
	var respawn_pos = CheckpointManager.get_current_checkpoint()
	global_position = respawn_pos
	# Game.current_health = 4  # Ensure this matches your actual health variable
	print("Respawned at checkpoint.")
