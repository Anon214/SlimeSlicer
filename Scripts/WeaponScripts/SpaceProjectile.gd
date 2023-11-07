extends Node2D

@export var speed: float = 100

var attack_damage: float = 10
var knockback_force: float = 10
var stun_time: float = 1.5
var attack_speed: float = 0.2

func set_speed(speed):
	self.speed = speed

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	
#the attack that hits the slime
func destroy(area):
	if area is HitboxComponent:
		
		var hitbox : HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.stun_time = stun_time
		hitbox.damage(attack)
	queue_free()


func _on_damagebox_component_area_entered(area): #area = hitbox
	destroy(area) # Replace with function body.


func _on_timer_timeout():
	queue_free()
