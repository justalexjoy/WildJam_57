extends Node

class_name Damageable

@export var health : int = 40

func hit(damage: int):
	health -= damage
	
	if (health <= damage):
		get_parent().queue_free()
