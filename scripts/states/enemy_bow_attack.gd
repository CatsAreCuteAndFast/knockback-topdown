extends State
class_name EnemyBowAttack

@export var range = 100
@export var time_to_reach_max = 0.8
@export var wait_after_shot = 0.5
@export var attack_cancel_radius = 80
@export var enemy : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D
@export var marker : Marker2D
@export var arrow : PackedScene
@export var load_sound : AudioStreamPlayer2D
@export var release_sound : AudioStreamPlayer2D

var current_time : float
var _shot_fired = false
var running = true
var player: Node2D

func _ready() -> void:
	set_process_priority(-100)
	
func _on_shot_fired():
	await get_tree().create_timer(wait_after_shot).timeout
	current_time = 0
	_shot_fired = false
	if running:
		load_sound.play()
		animated_sprite.play("load")

func Enter():
	player = get_tree().get_first_node_in_group("player")
	load_sound.play()
	animated_sprite.play("load")
	running = true

func Update(delta):
	var distance_to_player = enemy.global_position.distance_to(player.global_position)
	if distance_to_player > attack_cancel_radius:
		Transitioned.emit(self, "follow")
	if player.global_position.x - animated_sprite.global_position.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	marker.look_at(player.global_position)
	current_time += delta
	current_time = min(current_time, time_to_reach_max)
	current_time /= time_to_reach_max
	if current_time == 1:
		Fire()
	

func Fire():
	if not _shot_fired:
		_shot_fired = true
		release_sound.play()
		_on_shot_fired()
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = marker.rotation
		arrow_instance.global_position = marker.global_position
		var original_range = arrow_instance.range
		arrow_instance.range = range
		arrow_instance.speed *= arrow_instance.range / original_range
		arrow_instance.knockback_power = 0
		add_child(arrow_instance)
		var killzone = arrow_instance.get_node("Killzone")
		killzone._target_only_player = true

func Exit():
	current_time = 0
	running = false
