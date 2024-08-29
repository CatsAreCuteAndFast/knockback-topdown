extends State
class_name Attack

@onready var timer: Timer = $Timer
@onready var killzone: Area2D = $Killzone

@export var animated_sprite: AnimatedSprite2D
@export var enemy: CharacterBody2D
@export var move_speed := 50.0
@export var attack_cancel_radius := 30.0
@export var max_attack_distance := 20.0

var player: Node2D
var always_attack := true

signal AttackFinished

func _ready() -> void:
	animated_sprite.frame_changed.connect(_on_frame_changed)
	animated_sprite.animation_finished.connect(_on_animation_finished)
	AttackFinished.connect(_on_attack_finished)

func Enter():
	player = get_tree().get_first_node_in_group("player")
	timer.start()
	animated_sprite.play("attack")
	animated_sprite.stop()
	always_attack = true

func PhysicsUpdate(_delta: float):
	pass

func Exit():
	killzone.monitoring = false
	killzone.visible = false
	timer.stop()

func _on_animation_finished():
	if animated_sprite.animation == "attack":
		timer.start()

func _on_timer_timeout() -> void:
	AttackFinished.emit()
	
func _on_attack_finished():
	var distance_to_player = enemy.global_position.distance_to(player.global_position)
	if distance_to_player > attack_cancel_radius and not always_attack:
		Transitioned.emit(self, "Follow")
	else:
		set_killzone_position()
		animated_sprite.play("attack")
		if enemy.global_position > player.global_position:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	always_attack = false
	
func set_killzone_position():
	var direction_to_player = player.global_position - enemy.global_position
	var distance_to_player = direction_to_player.length()
	
	if distance_to_player <= max_attack_distance:
		killzone.global_position = player.global_position
	else:
		var limited_position = enemy.global_position + direction_to_player.normalized() * max_attack_distance
		killzone.global_position = limited_position
	
		
func _on_frame_changed():
	if animated_sprite.animation == "attack":
		match animated_sprite.frame:
			1:
				killzone.visible = true
			4:
				killzone.monitoring = true
			5:
				killzone.monitoring = false
				killzone.visible = false
			
		
