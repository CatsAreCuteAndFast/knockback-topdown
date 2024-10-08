extends State
class_name Follow

@export var animated_sprite : AnimatedSprite2D
@export var enemy: CharacterBody2D
@export var navigation_agent : NavigationAgent2D
@export var move_speed := 50.0
@export var detection_radius := 100.0
@export var attack_radius := 20.0

var player: Node2D

func makepath():
	navigation_agent.target_position = player.global_position

func Enter():
	player = get_tree().get_first_node_in_group("player")
	animated_sprite.play("run")

func PhysicsUpdate(_delta: float):
	var direction = enemy.to_local(navigation_agent.get_next_path_position()).normalized()
	enemy.velocity = direction * move_speed
	
	var distance_to_player = enemy.global_position.distance_to(player.global_position)
	if distance_to_player > detection_radius:
		Transitioned.emit(self, "Wander")
	if distance_to_player < attack_radius:
		Transitioned.emit(self, "Attack")

func Exit():
	enemy.velocity = Vector2.ZERO

func _on_timer_timeout() -> void:
	makepath()
