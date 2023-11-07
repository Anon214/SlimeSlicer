class_name Enemy
extends CharacterBody2D

@export var speed: float = 100
@export var attack_damage: float = 10
var knockback_force: float = 100
var stun_time: float = 1.5
var attack_speed: float = 0.2
var animator: AnimationPlayer
var friction : float = 200
var health_switch = true

@onready var player: Player = get_tree().get_first_node_in_group("Player") as Player
@onready var health : float = $HealthComponent.get_health()
@onready var max_health: float = $HealthComponent.get_max_health()
		
func get_speed():
	return speed
	
func get_animator():
	return $AnimationPlayer
	
func get_sprite():
	return $Sprite2D
	
func set_health(health):
	self.health = health
	if health_switch:
		health_switch = false
		
func die():
	queue_free()
	
func _ready():
	animator = get_animator()
	animator.play("chase")

func _physics_process(delta):
	var direction = (player.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * speed, friction * delta)
	get_sprite().flip_h = velocity.x > 0
	move_and_slide()
	
# Slime hits player
func _on_damagebox_component_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.stun_time = stun_time
		hitbox.damage(attack)
		

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent and area.get_parent() is Enemy:
		print("yes collide")
