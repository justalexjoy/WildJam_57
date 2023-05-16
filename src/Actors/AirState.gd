extends State

class_name AirState

const MAX_DASH_NUMBER = 2

@export var extra_jump_velocity : float = -300.0
@export var ground_state : State

var _dashCount : int = 2

func state_process(delta):
	if (player.is_on_floor()):
		next_state = ground_state
		playback.travel("Move")
	
func state_input(event: InputEvent):
	if (event.is_action_pressed("jump")):
		extra_jump()

func extra_jump():
	if _dashCount > 0:
		player.velocity.y = extra_jump_velocity * _dashCount/MAX_DASH_NUMBER
		_dashCount -= 1 
		playback.travel("jump")

func on_enter():
	_dashCount = 2
