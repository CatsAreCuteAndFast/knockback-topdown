extends Area2D

@export var damage = 1
@export var _target_only_player = true
@export var knockback_power = 500
@export var shake_power = 3.0
@export var shake_fade = 10.0

var camera : Camera2D
var knockback_direction : Vector2

signal DamageDealt(body: Node2D)

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")

func _on_body_entered(body: Node2D) -> void:
	var target_health = body.get_node("Health")
	if _target_only_player and body.is_in_group("player"):
		deal_damage(target_health)
		send_damage_dealt_signal(body)
	elif not _target_only_player and not body.is_in_group("player"):
		deal_damage(target_health)
		send_damage_dealt_signal(body)
			
func deal_damage(health_script: Health):
	if health_script != null:
		camera.Screenshake(shake_power, shake_fade)
		if knockback_direction != Vector2.ZERO:
			health_script.Damage(damage, knockback_direction, knockback_power)
		else:
			health_script.Damage(damage)
		
func send_damage_dealt_signal(body: Node2D):
	DamageDealt.emit(body)
	
	
