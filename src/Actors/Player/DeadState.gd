extends State


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "player_dead":
		game_over()


func game_over():
	get_tree().change_scene_to_file("res://UI/game_over_layer.tscn")
