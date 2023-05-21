extends Node
class_name CharacterStateMachine

@export var player: CharacterBody2D
@export var animation_tree: AnimationTree
@export var state: State

var states: Array[State]

func _ready():
	
	for child in get_children():
		if (child is State):
			states.append(child)
			child.player = player
			
			child.playback = animation_tree["parameters/playback"]
			
			#Connect to signals
			
			child.connect("interrupt_state", on_state_interrupt)
			
		else:
			assert("Wrong child")

func _physics_process(delta):
	state.state_process(delta)
	
	if (state.next_state != null):
		swich_states(state.next_state)

func _input(event):
	state.state_input(event)

func get_speed() -> float:
	return state.move_speed
	
func swich_states(new_state: State):
	if (state != null):
		state.on_exit()
		state.next_state = null
		
	state = new_state
	
	state.on_enter()

func on_state_interrupt(new_state: State):
	swich_states(new_state)
