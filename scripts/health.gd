extends Node
class_name Health

@export var max_health = 3
@export var immunity_frame_duration = 1.0

var last_hit_time : float

var current_health : int

signal on_death
signal health_changed

func _ready() -> void:
	current_health = max_health
	
func Damage(amount : int):
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_hit_time > immunity_frame_duration:
		current_health -= amount
		last_hit_time = current_time
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
	on_death.emit()
	
func send_signal():
	health_changed.emit(current_health)
	if current_health <= 0:
		die()
