class_name SceneTrigger extends Area2D

@export var connected_scene : String 
var scene_folder =  "res://"

func _on_body_entered(body):
    print("Scene Body Entered")
    var full_path = scene_folder +  connected_scene  +  ".tscn"
    var scene_tree = get_tree()
    scene_tree.call_deferred("change_scene_to_file", full_path)
