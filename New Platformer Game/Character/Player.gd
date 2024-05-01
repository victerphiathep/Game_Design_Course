extends CharacterBody2D

class_name Player

# Summary
# -----------------------------------
# Controls left right movement for player input when state machine
# permits movement
#
# Also flips sprite direction when moving right or left and 
# emits signal to let other scripts know what direction the player is facing

@export var speed : float = 250.0
@export var Gold = 0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var checkpoint_position: Vector2

signal facing_direction_changed(facing_right : bool)

func _ready():
    add_to_group("Player")
    animation_tree.active = true
    
    checkpoint_position = global_position # Initialize with starting position

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    direction = Input.get_vector("left", "right", "up", "down")
    
    # Control whether to move or not to move
    if direction.x != 0 && state_machine.check_if_can_move():
        velocity.x = direction.x * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)
        
    if Game.currentHealth <= 0:
        # Respawn if health is zero
        respawn()

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
    checkpoint_position = position # Update checkpoint position

func respawn():
    var respawn_pos = CheckpointManager.get_current_checkpoint()
    global_position = respawn_pos
    Game.currentHealth = 4  # Reset health
    print("Respawned at checkpoint.")
    


func _on_area_2d_body_entered(body):
    if body.is_in_group("Player"):
        print("Second Checkpoint Mark")
