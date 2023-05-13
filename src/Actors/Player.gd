extends Actor


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_DASH_NUMBER = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $AnimatedSprite2D

var _state = CharacterState.STAY
var _dashCount = 0
var _direction = 0

enum CharacterState {
  WALK,
  STAY,
  JUMP,
}

func _physics_process(delta):
	get_state()
	get_input()

	var force = 0
	if is_on_floor():
		force = SPEED
	else:
		force = SPEED * 0.6

	if _direction:		
		velocity.x = _direction * force
	else:		 
		velocity.x = move_toward(velocity.x, 0, force)

	if not is_on_floor():
		velocity.y += gravity * delta

	animate_state()
	move_and_slide()
	check_falling()
	
func get_input():
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and _dashCount > 0:
		velocity.y = JUMP_VELOCITY * 0.8 * _dashCount/MAX_DASH_NUMBER
		_dashCount -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	_direction = Input.get_axis("ui_left", "ui_right")

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
	match _state:
		CharacterState.JUMP:
			sprite.play("jump")
		CharacterState.WALK:
			sprite.play("run")
		CharacterState.STAY:
			sprite.play("idle")

	sprite.flip_h = _direction < 0

func check_falling():
	if global_position.y > 1000:
		get_tree().change_scene_to_file("res://UI/game_over_layer.tscn")

