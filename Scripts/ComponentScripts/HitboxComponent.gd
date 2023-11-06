extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var knockback_component : KnockbackComponent

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
	if knockback_component:
		knockback_component.damage(attack)
		
	collision.call_deferred("set", "disabled", true)
	disableTimer.start()


func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
