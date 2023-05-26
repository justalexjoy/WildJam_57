extends CanvasLayer


func _on_restart_button_pressed():
#	get_tree().root.reload_current_scene()
#	get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://src/Main/Game.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
