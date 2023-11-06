extends Node2D
class_name HealthComponent

@export var max_health : float = 100
@onready var health : float = max_health

func get_max_health():
	return max_health

func get_health():
	return health

func damage(attack : Attack):
	health -= attack.attack_damage
	get_parent().set_health(health)
	print(get_parent(), health)
	
	if health <= 0:
		get_parent().die()
