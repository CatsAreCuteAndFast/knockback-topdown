extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var killzone: Area2D = $Killzone

@export var speed = 100.0
@export var range = 100.0
@export var knockback_power = 500.0

var current_scale : float
var original_pos : Vector2
var _is_flying = true

func _ready() -> void:
	original_pos = position
	killzone.knockback_direction = original_pos
	killzone.knockback_power = knockback_power
	set_as_top_level(true)
	
func _process(delta: float) -> void:
	if _is_flying:
		position += (Vector2.RIGHT * speed).rotated(rotation) * delta
		current_scale = 0.845 + original_pos.distance_to(position) / range / 2
		if current_scale > 1:
			current_scale = 1 - (current_scale - 1)
		if original_pos.x > position.x:
			sprite.scale.x = current_scale
		else:
			sprite.scale.x = current_scale
		if original_pos.distance_to(position) > range:
			_on_hit_ground()
			
func _on_hit_ground():
	_is_flying = false
	killzone.monitoring = false
	z_index = 1
	await get_tree().create_timer(2).timeout
	queue_free()

func _on_killzone_damage_dealt(body: Node2D) -> void:
	queue_free()
