extends CharacterBody2D

@export var knife_scene: PackedScene
@export var goblin_speed : float = 50
@export var right_corner : float = 50
@export var left_corner : float = 50

var righttrue_leftfalse : bool = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = WALK
var kurok = 0
var kurok2 = true
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
	if global_position.x > right_corner:
		righttrue_leftfalse = false
	if global_position.x < left_corner:
		righttrue_leftfalse = true
		

	if not is_on_floor():
		velocity.y += gravity * delta

	match state:
		IDLE:
			$AnimatedSprite2D.animation = "IDLE"
		WALK:
			
			$AnimatedSprite2D.animation = "WALK"

			if righttrue_leftfalse == true:
				global_position.x += goblin_speed * delta
				$AnimatedSprite2D.flip_h = false
			if righttrue_leftfalse == false:
				global_position.x -= goblin_speed * delta
				$AnimatedSprite2D.flip_h = true
			
			
		ATTACK_MODE:
			if global_position.x > get_tree().get_root().get_node("Game").get_node("Player").get("global_position").x:
				$AnimatedSprite2D.flip_h = true
			if global_position.x < get_tree().get_root().get_node("Game").get_node("Player").get("global_position").x:
				$AnimatedSprite2D.flip_h = false
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
	var bullet: Node2D = knife_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.rotation = (bullet.position - get_tree().get_root().get_node("Game").get_node("Player").get("global_position")).angle() + PI
	if global_position.x > get_tree().get_root().get_node("Game").get_node("Player").get("global_position").x:
			bullet.scale.x = bullet.scale.x
			bullet.scale.y = -bullet.scale.y
	if global_position.x < get_tree().get_root().get_node("Game").get_node("Player").get("global_position").x:
			bullet.scale.x = bullet.scale.x

	
	
	
#	if is_moving_left == false:
#		bullet.global_rotation = PI

func _on_detector_body_entered(body):
	if body.is_in_group("Player"):
		state = ATTACK_MODE

func _on_un_detector_body_exited(body):
	if body.is_in_group("Player"):
		state = WALK
