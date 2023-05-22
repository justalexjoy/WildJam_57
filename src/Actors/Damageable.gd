extends Node

class_name Damageable

signal on_hit(node: Node, damage_taken: int)

@export var health : int = 40:
	get: 
		return health
	set(newValue):
		SignalBus.emit_signal("on_health_changed", get_parent(), newValue - health)
		health = newValue
	

func hit(damage: int):
	health -= damage
	print("take damage: %d" % damage)
	print("health: %d" % health)
	emit_signal("on_hit", get_parent(), damage)
	

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "dead": # тут у разных персонжей может быть разная анимация. по идее в @export надо вынести
		get_parent().queue_free()
