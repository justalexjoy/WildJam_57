extends Area2D

@export var damage: int = 5
@export var speed : int = 250

func _ready():
	monitoring = false

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	print(body)
	for child in body.get_children():
		if child is Damageable:
			print("child: " + child.name)
			child.hit(damage)
	
	queue_free()


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print(body)
