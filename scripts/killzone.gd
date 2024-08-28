extends Area2D

@export var damage = 1
@export var _target_only_player = true
@export var knockback_power = 500

var knockback_direction : Vector2

signal DamageDealt(body: Node2D)

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
		if knockback_direction != Vector2.ZERO:
			health_script.Damage(damage, knockback_direction, knockback_power)
		else:
			health_script.Damage(damage)
		
func send_damage_dealt_signal(body: Node2D):
	DamageDealt.emit(body)
	
	
