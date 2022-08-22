class_name DamageNumber2D
extends Node2D

@onready var label:Label = %Label
@onready var label_container:Node2D = %LabelContainer
@onready var ap:AnimationPlayer = %AnimationPlayer

@export var up_distance = 120

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_value(value:String) -> void:
	label.text = value
	ap.play("Rise and Fade")
	var tween = get_tree().create_tween()
	var start_pos = Vector2(randf_range(-10,10),randf_range(-5,5))
	var end_pos = Vector2(randf_range(-30,30),-up_distance)
	var tween_length = ap.get_animation("Rise and Fade").length
	
	tween.tween_property(label_container,"position",end_pos,tween_length).from(start_pos)


func remove() -> void:
	ap.stop()
	if is_inside_tree():
		get_parent().remove_child(self)
