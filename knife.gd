extends Area2D

@export var speed : int = 100

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta

 

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
