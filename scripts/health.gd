extends Node
class_name Health

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var max_health = 3
@export var immunity_frame_duration = 0.0

var shields = 0
var last_hit_time : float
var _is_dead = false
var current_health : int

signal on_death
signal health_changed

func _ready() -> void:
	current_health = max_health
	
func Damage(amount : int):
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_hit_time > immunity_frame_duration and not _is_dead:
		last_hit_time = current_time
		if shields > 0:
			shields -= 1
			return
		current_health -= amount
		animation_player.play("flicker")
		send_signal()
	
func Heal(amount : int):
	current_health += amount
	# detect if health is over max
	if current_health > max_health:
		current_health = max_health
	send_signal()
	
func reset_health():
	current_health = max_health
	send_signal()
	
func die():
	_is_dead = true
	on_death.emit()
	
func send_signal():
	health_changed.emit(current_health)
	if current_health <= 0:
		die()
