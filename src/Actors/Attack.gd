extends State

class_name AttackState

@export var ground_state : State

func state_process(delta):
	pass
	
func state_input(event: InputEvent):
	pass

func on_enter():
	pass


func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "attack"):
		next_state = ground_state
		playback.travel("Move")
