extends Node2D
class_name KnockbackComponent

@export var knockback_force : float = 10

func damage(attack : Attack):
	print("hi")
	var knockback_direction = attack.attack_position.direction_to(self.global_position)
	get_parent().velocity = knockback_direction * 150
