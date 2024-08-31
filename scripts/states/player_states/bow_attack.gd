extends State
class_name PlayerBowAttack

@onready var joystick: VirtualJoystick = $"../../Test/UI/Virtual joystick right"

@export var marker : Marker2D
@export var arrow : PackedScene
@export var _target_player = true
@export var minimum_range = 40
@export var maximum_range = 100
@export var time_to_reach_max = 0.8
@export var wait_after_shot = 0.5
@export var animated_sprite : AnimatedSprite2D
@export var knockback_power = 100
@export var shake_power = 10.0
@export var load_sound : AudioStreamPlayer2D
@export var release_sound : AudioStreamPlayer2D

var current_time : float
var _shot_fired = false

func _ready() -> void:
	set_process_priority(-100)
	
func _on_shot_fired():
	await get_tree().create_timer(wait_after_shot).timeout
	Transitioned.emit(self, "idle")
	_shot_fired = false

func Enter():
	animated_sprite.play("load")
	marker.show()
	load_sound.play()

func Update(delta):
	var joystick_pos = joystick.output
	if joystick_pos.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	marker.rotation = atan2(joystick_pos.y, joystick_pos.x)
	current_time += delta
	current_time = min(current_time, time_to_reach_max)
	marker.scale.x = max(current_time * 5, 0.2)

func Exit():
	if not _shot_fired:
		release_sound.play()
		marker.hide()
		_on_shot_fired()
		_shot_fired = true
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = marker.rotation
		arrow_instance.global_position = marker.global_position
		var original_range = arrow_instance.range
		arrow_instance.range = lerp(minimum_range, maximum_range, current_time / time_to_reach_max)
		arrow_instance.speed *= arrow_instance.range / original_range
		arrow_instance.knockback_power = knockback_power
		add_child(arrow_instance)
		
		var killzone = arrow_instance.get_node("Killzone")
		killzone.shake_power = shake_power
		if _target_player:
			killzone._target_only_player = true
		else:
			killzone._target_only_player = false
	current_time = 0
