extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree

# Walks left by default
@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 30.0
@export var hit_state : State
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Player detection
@export var player: Player
var chase = false

func _ready():
	animation_tree.active = true
	player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Will move if in a CharacterStateMachine State that allows movement
	if chase:
		var direction : Vector2 = starting_move_direction
		if direction && state_machine.check_if_can_move():
			velocity.x = direction.x * movement_speed
		# Reduce movement if not in the hit state (hit state has it's only movement rules for knockback)
		elif state_machine.current_state != hit_state:
			velocity.x = move_toward(velocity.x, 0, movement_speed)
	else:
		velocity.x = 0

	move_and_slide()

func pursue_player(delta):
	if player:  # Make sure player is not null
		var direction = (player.global_position - global_position).normalized()
		get_node("AnimatedSprite2D").flip_h = direction.x > 0


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
