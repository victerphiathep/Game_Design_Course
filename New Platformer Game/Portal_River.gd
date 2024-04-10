extends Area2D

func _on_body_entered(body):
    if body.is_in_group("Player"):
        var current_scene_file = get_tree().current_scene.scene_file_path
        var world = "res://world_2_river.tscn"
        get_tree().change_scene_to_file(world)
