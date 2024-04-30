extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var player
var chase = false

@export var player: Player
var hp = 4

signal healthChanged 
signal frog_defeated # Signal frog to be beat

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	player = get_tree().get_nodes_in_group("Player")[0]
	
func _physics_process(delta):
	velocity.y += gravity * delta
	if chase:
		pursue_player(delta)
	else:
		velocity.x = 0
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")

	move_and_slide()

func pursue_player(delta):
	if get_node("AnimatedSprite2D").animation != "Death":
		get_node("AnimatedSprite2D").play("Jump")
	if player:  # Make sure player is not null
		var direction = (player.global_position - global_position).normalized()
		get_node("AnimatedSprite2D").flip_h = direction.x > 0
		velocity.x = direction.x * SPEED
	
func apply_damage(damage_amount):
	hp -= damage_amount
	emit_signal("healthChanged", hp)
	if hp <= 0:
		death()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()
func _on_player_collison_body_entered(body):
	if body.name == "Player":
		Game.hurtByEnemy(body)  # Call the function with parentheses
		death()
func death():
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	emit_signal("frog_defeated")  # Optional, if you want to notify other parts of your game
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()

func _on_SwordHitbox_area_entered(area):
	if area.is_in_group("sword"):
		print("Frog hit")  # Assuming you have a group 'sword' for the sword's hitbox
		apply_damage(2)  # Apply damage of 2
