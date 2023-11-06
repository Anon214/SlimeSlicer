class_name Player
extends CharacterBody2D

@export var speed: float = 300
@export var weapon: Weapon

@onready var health : float = $HealthComponent.get_health()
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var timer = $AttackSpeed
@onready var space_wand = $SpaceWand

var key_held = true
var health_switch = true

func set_health(health):
	self.health = health
	if health_switch:
		health_switch = false

func _process(delta):
	if Input.is_action_pressed("action_attack") and key_held:
		space_wand.shoot()
		key_held = false
		timer.start()
	
func _on_attack_speed_timeout():
	key_held = true
	
func die():
	print("dead")
		

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	update_animation_parameters(direction)

	velocity = direction * speed
	
	move_and_slide()
	
	
func update_animation_parameters(direction : Vector2):
	if direction != Vector2.ZERO:
		state_machine.travel("Run")
		animation_tree.set("parameters/Run/blend_position", direction)
		animation_tree.set("parameters/Idle/blend_position", direction)
	else: 
		state_machine.travel("Idle")

