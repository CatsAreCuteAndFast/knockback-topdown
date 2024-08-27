extends State
class_name BowAttack

@export var marker : Marker2D
@export var arrow : PackedScene
@export var _target_player = true
@export var minimum_range = 40
@export var maximum_range = 100
@export var time_to_reach_max = 0.8
@export var wait_after_shot = 0.5
@export var animated_sprite : AnimatedSprite2D

var current_time : float
var _shot_fired = false
var time_after_shot : float

func _ready() -> void:
	set_process_priority(-100)
	
func _process(delta: float) -> void:
	if _shot_fired:
		time_after_shot += delta
		if time_after_shot > wait_after_shot:
			Transitioned.emit(self, "idle")

func Enter():
	animated_sprite.play("load")

func Update(delta):
	var mouse_pos = marker.get_global_mouse_position()
	if mouse_pos.x - animated_sprite.global_position.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	marker.look_at(mouse_pos)
	current_time += delta
	current_time = min(current_time, time_to_reach_max)
	current_time /= time_to_reach_max
	

func Exit():
	_shot_fired = true
	var arrow_instance = arrow.instantiate()
	arrow_instance.rotation = marker.rotation
	arrow_instance.global_position = marker.global_position
	var original_range = arrow_instance.range
	arrow_instance.range = lerp(minimum_range, maximum_range, current_time)
	arrow_instance.speed *= arrow_instance.range / original_range
	add_child(arrow_instance)
	
	var killzone = arrow_instance.get_node("Killzone")
	if _target_player:
		killzone._target_only_player = true
	else:
		killzone._target_only_player = false
	current_time = 0
