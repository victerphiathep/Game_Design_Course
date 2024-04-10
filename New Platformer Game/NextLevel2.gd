extends Area2D

func _on_body_entered(body):
    if body.is_in_group("Player"):
        var current_scene_file = get_tree().current_scene.scene_file_path
        var world_3_village_path = "res://world_3_village.tscn"
        get_tree().change_scene_to_file(world_3_village_path)
        print("Collided Village!")
        
        
