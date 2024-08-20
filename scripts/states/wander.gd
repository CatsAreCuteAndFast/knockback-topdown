extends State
class_name Wander

@export var animated_sprite : AnimatedSprite2D
@export var enemy : CharacterBody2D
@export var moveSpeed := 10
@export var detection_radius := 200.0

var move_direction : Vector2
var wander_time : float
var player: CharacterBody2D

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	
func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()
	animated_sprite.play("walk")
	
func Update(delta : float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	var distance_to_player = enemy.global_position.distance_to(player.global_position)
	if detection_radius >= distance_to_player:
		Transitioned.emit(self, "Follow")
		
func PhysicsUpdate(delta : float):
	if enemy:
		enemy.velocity = move_direction * moveSpeed
