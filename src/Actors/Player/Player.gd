extends CharacterBody2D

class_name PlayerCharacter

const SPEED = 350.0
const JUMP_VELOCITY = -400.0
const MAX_DASH_NUMBER = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _state = CharacterState.STAY
var _dashCount = 0
var _direction = 0

var can_move : bool = true

enum CharacterState {
  WALK,
  STAY,
  JUMP,
  ATTACK
}

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	get_state()
	get_input()

	var speed = state_machine.get_speed()

	if _direction and state_machine.state.can_move:
		velocity.x = _direction * speed
	else:		 
		velocity.x = move_toward(velocity.x, 0, speed)

	if not is_on_floor():
		velocity.y += gravity * delta

	animate_state()
	move_and_slide()
	check_falling()
	
func get_input():
#	if Input.is_action_just_pressed("jump") and not is_on_floor() and _dashCount > 0:
#		velocity.y = JUMP_VELOCITY * 0.8 * _dashCount/MAX_DASH_NUMBER
#		_dashCount -= 1
		
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		_state = CharacterState.ATTACK

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	_direction = Input.get_axis("left", "right")

func get_state():
	if is_on_floor() and _direction:
		_state = CharacterState.WALK

	if is_on_floor():
		_dashCount = MAX_DASH_NUMBER

	if not is_on_floor() and _direction:
		_state = CharacterState.JUMP

	if not _direction:
		_state = CharacterState.STAY

func animate_state():
	animation_tree.set("parameters/Move/blend_position", _direction)

	if _direction != 0:
		sprite.flip_h = _direction < 0

func check_falling():
	if global_position.y > 1000:
		game_over()

func game_over():
	get_tree().change_scene_to_file("res://UI/game_over_layer.tscn")
