extends Node2D

@onready var spawn_point = %SpawnPoint
@onready var damage_number_2d_template = load("res://Damage_Number_2D.tscn")

var damage_number_2d_pool:Array[DamageNumber2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click") or event.is_action_pressed("Right Click"):
		spawn_damage_number(randf_range(0,10))
	
func spawn_damage_number(value:float):
	var damage_number = get_damage_number()
	add_child(damage_number, true)	
	damage_number.set_value(str(round(value)))
	damage_number.position = spawn_point.position

func get_damage_number() -> DamageNumber2D:
	if damage_number_2d_pool.size() > 0:
		return damage_number_2d_pool.pop_front()
		
	else:
		var new_damage_number = damage_number_2d_template.instantiate()
		new_damage_number.tree_exiting.connect(
			func():damage_number_2d_pool.append(new_damage_number))
		return new_damage_number
		
	
		
