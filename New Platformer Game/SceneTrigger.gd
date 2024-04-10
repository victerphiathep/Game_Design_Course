class_name SceneTrigger extends Area2D

@export var connected_scene : String 

func _on_body_entered(body):
    print("Scene Body Entered")
    if body is Player:
        scene_manager.change_scene(get_owner(), connected_scene)
