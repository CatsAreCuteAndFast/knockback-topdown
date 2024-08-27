extends Node2D

@export var speed = 100.0

func _ready() -> void:
	set_as_top_level(true)
	
func _process(delta: float) -> void:
	position += (Vector2.RIGHT * speed).rotated(rotation) * delta

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func _on_killzone_damage_dealt(body: Node2D) -> void:
	queue_free()
