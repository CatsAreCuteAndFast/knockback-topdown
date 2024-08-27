extends Area2D

@export var damage = 1
@export var _target_only_player = true

func _on_body_entered(body: Node2D) -> void:
	var target_health = body.get_node("Health")
	if _target_only_player and body.is_in_group("player"):
		deal_damage(target_health)
	elif not _target_only_player and not body.is_in_group("player"):
		deal_damage(target_health)
			
func deal_damage(health_script: Health):
	if health_script != null:
		health_script.Damage(damage)
	
