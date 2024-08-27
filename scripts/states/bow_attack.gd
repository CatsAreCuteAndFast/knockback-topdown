extends State
class_name BowAttack

@export var marker : Marker2D
@export var arrow : PackedScene
@export var _target_player = true

func Update(delta):
	var mouse_pos = marker.get_global_mouse_position()
	marker.look_at(mouse_pos)
	

func Exit():
	var arrow_instance = arrow.instantiate()
	arrow_instance.rotation = marker.rotation
	arrow_instance.global_position = marker.global_position
	add_child(arrow_instance)
	
	var killzone = arrow_instance.get_node("Killzone")
	if _target_player:
		killzone._target_only_player = true
	else:
		killzone._target_only_player = false
