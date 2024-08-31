extends Node
class_name Health

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var entity: CharacterBody2D = $".."

@export var max_health = 3
@export var immunity_frame_duration = 0.0
@export var shields = 0
@export var on_damage_taken_sound : AudioStreamPlayer2D

var last_hit_time : float
var _is_dead = false
var current_health : int

var is_in_knockback = false
var knockback_velocity = Vector2.ZERO

signal on_death
signal health_changed

func _ready() -> void:
	current_health = max_health
	
func _physics_process(delta):
	if is_in_knockback:
		entity.velocity = knockback_velocity
	
func Damage(amount : int, knockback_direction = Vector2(1, 1), knockback_power = 0):
	var current_time = Time.get_ticks_msec() / 1000.0
	on_damage_taken_sound.play()
	if current_time - last_hit_time > immunity_frame_duration and not _is_dead:
		last_hit_time = current_time
		if shields > 0:
			shields -= 1
			return
		current_health -= amount
		animation_player.play("flicker")
		if knockback_power > 0:
			apply_knockback(knockback_direction, knockback_power)
		send_signal()
		
func apply_knockback(direction: Vector2, power: float):
	is_in_knockback = true
	var final_knockback_direction = direction - entity.global_position
	knockback_velocity = final_knockback_direction.normalized() * -power
	
	# Create a tween for smooth deceleration
	var tween = create_tween()
	tween.tween_property(self, "knockback_velocity", Vector2.ZERO, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(func(): is_in_knockback = false)
	
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
