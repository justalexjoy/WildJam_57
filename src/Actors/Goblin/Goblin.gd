extends CharacterBody2D

@export var knife_scene: PackedScene
@export var goblin_speed : float = 50
@export var right_corner : float = 50
@export var left_corner : float = 50

@onready var body_sprite: AnimatedSprite2D = $AnimatedSprite2D

var righttrue_leftfalse : bool = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = WALK
var kurok = 0
var kurok2 = true

var direction = 1

enum {
	WALK,
	IDLE,
	ATTACK_MODE,
	ATTACK
}

func _ready():
	right_corner = global_position.x + right_corner
	left_corner = global_position.x - left_corner
	
func _physics_process(delta):

	var is_at_right_corner = global_position.x > right_corner
	var is_at_left_corner = global_position.x < left_corner
	
	if is_at_right_corner:
		direction = 1
	elif is_at_left_corner:
		direction = -1

#	if is_on_wall():
#		direction = -1 * direction

	if not is_on_floor():
		velocity.y += gravity * delta

	match state:
		IDLE:
			body_sprite.animation = "IDLE"
		WALK:
			
			body_sprite.animation = "WALK"

			if direction != 0:
				global_position.x -= direction * goblin_speed * delta
				body_sprite.flip_h = direction > 0 
				
		
		ATTACK_MODE:
			var player = get_tree().get_root().get_node("Game").get_node("Player")
			
			$AnimatedSprite2D.flip_h = global_position.x > player.get("global_position").x
			$AnimatedSprite2D.animation = "ATTACK_MODE"
			if $Cooldown.is_stopped():
				$Cooldown.start(2)
				state = ATTACK
				kurok = 1
		
		ATTACK:
			$AnimatedSprite2D.animation = "ATTACK"
			if $AnimatedSprite2D.get_frame() == 7:
				state = ATTACK_MODE
			if $AnimatedSprite2D.get_frame() == 5 and kurok == 1:
				throw_knife()
				kurok = 0
	move_and_slide()

func throw_knife():
	var bullet: Node2D = make_knife()
	
	var player = get_tree().get_root().get_node("Game").get_node("Player")
	
	bullet.rotation = (bullet.position - player.get("global_position")).angle() + PI
	if global_position.x > player.get("global_position").x:
			bullet.scale.x = bullet.scale.x
			bullet.scale.y = -bullet.scale.y
	if global_position.x < player.get("global_position").x:
			bullet.scale.x = bullet.scale.x

#	if is_moving_left == false:
#		bullet.global_rotation = PI

func make_knife() -> Node2D:
	var bullet: Area2D = knife_scene.instantiate()
	
	var current_scene = get_tree().current_scene
	var parent_scene = current_scene.get_parent()
	
	get_tree().current_scene
	
	"Level"
	
	print(get_parent())
	print(current_scene.name)
	print(parent_scene.name)
	
	parent_scene.add_child(bullet)
	bullet.global_position = global_position
	
	return bullet
	
func _on_detector_body_entered(body):
	if body.is_in_group("Player"):
		state = ATTACK_MODE

func _on_un_detector_body_exited(body):
	if body.is_in_group("Player"):
		state = WALK
