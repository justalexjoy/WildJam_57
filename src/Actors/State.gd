extends Node

class_name State

@export var can_move : bool = true
@export var move_speed : float = 300.0

var player: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback
var next_state: State

signal interrupt_state(new_state: State)

func state_input(event: InputEvent):
	pass

func state_process(delta):
	pass

func on_enter():
	pass
	
func on_exit():
	pass
