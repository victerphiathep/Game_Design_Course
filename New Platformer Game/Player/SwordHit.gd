extends Area2D

var damage_amount = 2

func _ready():
    # Corrected for Godot 4 using Callable for signal connection
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    print("Body Entered")
    if body.has_method("apply_damage"):
        body.apply_damage(damage_amount)
