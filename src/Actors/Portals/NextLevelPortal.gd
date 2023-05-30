extends Area2D

@export var nextLevel: PackedScene

func _on_body_entered(body):
	if body is PlayerCharacter:
		get_tree().change_scene_to_packed(nextLevel)
