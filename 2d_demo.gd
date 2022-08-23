extends Control

@onready var spawn_point = %SpawnPoint
@onready var damage_number_2d_template = preload("res://Damage_Number_2D.tscn")
@onready var spread_value:Label = %"Spread Value"
@onready var height_value:Label = %"Height Value"

var damage_number_2d_pool:Array[DamageNumber2D] = []
var rmb_held = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if rmb_held:
		spawn_damage_number(randf_range(0,10))

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click"):
		spawn_damage_number(randf_range(0,1000))
		
	if event.is_action_pressed("Right Click"):
		rmb_held = true
		
	if event.is_action_released("Right Click"):
		rmb_held = false
		
	
func spawn_damage_number(value:float):
	var damage_number = get_damage_number()	
	var val = str(round(value))
	var pos = spawn_point.position
	var height = height_value.text.to_float()
	var spread = spread_value.text.to_float()
	add_child(damage_number, true)
	damage_number.set_values_and_animate(val, pos, height, spread)

func get_damage_number() -> DamageNumber2D:
	# get a damage number from the pool
	if damage_number_2d_pool.size() > 0:
		return damage_number_2d_pool.pop_front()
	
	# create a new damage number if the pool is empty
	else:
		var new_damage_number = damage_number_2d_template.instantiate()
		new_damage_number.tree_exiting.connect(
			func():damage_number_2d_pool.append(new_damage_number))
		return new_damage_number


func _on_spread_value_changed(value: float) -> void:
	spread_value.text = str(value)


func _on_height_value_changed(value: float) -> void:
	height_value.text = str(value)
