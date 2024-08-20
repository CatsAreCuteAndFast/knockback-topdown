extends State
class_name Follow

@export var enemy: CharacterBody2D
@export var move_speed := 50.0
@export var detection_radius := 200.0

var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")

func PhysicsUpdate(delta: float):
	if enemy and player:
		var distance_to_player = enemy.global_position.distance_to(player.global_position)
		
		if distance_to_player <= detection_radius:
			var direction = (player.global_position - enemy.global_position).normalized()
			enemy.velocity = direction * move_speed
		else:
			Transitioned.emit(self, "Wander")

func Exit():
	enemy.velocity = Vector2.ZERO
