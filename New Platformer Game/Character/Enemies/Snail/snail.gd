extends CharacterBody2D

@onready var sprite : Sprite2D = $Sprite2D  # Assuming the Sprite node is direct child
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Default movement direction is left
@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 30.0
@export var hit_state : State

# Player detection chase
var chase = false
var player : Node

# Gravity setup
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_player.active = true
	player = get_tree().get_nodes_in_group("Player")[0]  # Assuming Player is in 'Player' group

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movement and sprite orientation
	if chase and player:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * movement_speed
		sprite.flip_h = direction.x > 0  # Flip sprite based on direction
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.is_in_group("Player"):
		chase = true

func _on_player_detection_body_exited(body):
	if body.is_in_group("Player"):
		chase = false
