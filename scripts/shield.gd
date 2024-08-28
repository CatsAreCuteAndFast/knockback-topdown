extends Node2D

@export var regen_shield_timer = 0.0
@export var starting_with_shield = true
@export var health_script : Health
@export var shield_sprite : Sprite2D

var current_shield_timer : float

func _ready() -> void:
	if starting_with_shield:
		health_script.shields = 1
	current_shield_timer = regen_shield_timer
		
func _process(delta: float) -> void:
	if health_script.shields == 0:
		shield_sprite.hide()
		if regen_shield_timer != 0.0:
			current_shield_timer -= delta
	if current_shield_timer < 0:
		shield_sprite.show()
		health_script.shields = 1
		current_shield_timer = regen_shield_timer
		

func _on_health_on_death() -> void:
	queue_free()
