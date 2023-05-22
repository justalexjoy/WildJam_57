extends Area2D

@export var damage: int = 5
@export var speed : int = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta


func _on_body_entered(body):
	print(body.name)

	if body is PlayerCharacter:
		print("body: " + body.name)
		
		for child in body.get_children():
			if child is Damageable:
				print("child: " + child.name)
				child.hit(damage)

		queue_free()
