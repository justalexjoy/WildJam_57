extends State

@export var damagable: Damageable
@export var charackter_state_machine: CharacterStateMachine
@export var dead_state: State
@export var dead_animation_node: String = "dead"

func _ready():
	
	damagable.connect("on_hit", on_damagable_hit)
	
	
func on_damagable_hit(node: Node, damage: int):
	if damagable.health > 0:
		emit_signal("interrupt_state", self)
	else:
		next_state = dead_state
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)
