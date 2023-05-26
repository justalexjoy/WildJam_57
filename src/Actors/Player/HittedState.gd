extends State

@export var damagable: Damageable
@export var charackter_state_machine: CharacterStateMachine

@export var default_state: State
@export var default_animation_node: String = "Move"

@export var dead_state: State
@export var dead_animation_node: String = "dead"


func _ready():
	damagable.connect("on_hit", on_damagable_hit)
	
	
func on_damagable_hit(node: Node, damage: int):
	if damagable.health > 0:
		emit_signal("interrupt_state", self)
		playback.travel("hit")
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "hit"):
		emit_signal("interrupt_state", default_state)
		playback.travel(default_animation_node)
