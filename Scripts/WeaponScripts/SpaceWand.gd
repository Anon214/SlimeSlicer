extends Node2D
class_name Weapon

@export var attack = preload("res://Weapons/Magic/SpaceProjectile.tscn")
@export var move_speed : float = 300

func get_sprite():
	return $Sprite2D

func shoot():
	if attack:
		var inst = attack.instantiate()
		inst.set_speed(move_speed)
		get_tree().current_scene.add_child(inst)
		inst.global_position = self.global_position
		
		var inst_rotation = self.global_position.direction_to(get_global_mouse_position()).angle()
		inst.rotation = inst_rotation
		
