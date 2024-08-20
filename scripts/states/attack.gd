extends State
class_name Attack

@onready var timer: Timer = $Timer

@export var animated_sprite: AnimatedSprite2D
@export var enemy: CharacterBody2D
@export var move_speed := 50.0
@export var attack_cancel_radius := 200.0

var player: Node2D

var always_attack := true

signal AttackFinished

func Enter():
	player = get_tree().get_first_node_in_group("player")
	timer.start()
	animated_sprite.play("attack")
	animated_sprite.stop()
	animated_sprite.animation_finished.connect(_on_animation_finished)
	AttackFinished.connect(_on_attack_finished)
	always_attack = true

func PhysicsUpdate(delta: float):
	pass

func Exit():
	enemy.velocity = Vector2.ZERO

func _on_animation_finished():
	timer.start()

func _on_timer_timeout() -> void:
	AttackFinished.emit()
	
func _on_attack_finished():
	var distance_to_player = enemy.global_position.distance_to(player.global_position)
	if distance_to_player > attack_cancel_radius and not always_attack:
		Transitioned.emit(self, "Follow")
	else:
		animated_sprite.play("attack")
	always_attack = false
