extends State


func _on_animation_tree_animation_finished(anim_name):
	print("anim_name: %s" % anim_name)
	
	if anim_name == "dead":
		game_over()


func game_over():
	get_tree().change_scene_to_file("res://UI/GameOver2.tscn")
