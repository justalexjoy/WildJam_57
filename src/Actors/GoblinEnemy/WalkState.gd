extends State

var direction = -1
@export var goblin_speed: float = 50
@export var body_sprite: Sprite2D
@export var charachter: CharacterBody2D

func state_process(delta):
	
	if charachter.is_on_wall():
		direction = -1 * direction
	
	if direction != 0:
		charachter.global_position.x -= direction * goblin_speed * delta
		body_sprite.flip_h = direction > 0 
