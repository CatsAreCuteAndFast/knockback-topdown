extends State
class_name Death

@export var reset_scene = false
@export var parent_node : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D

func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animation_finished)

func Enter():
	animated_sprite.play("death")
	
func Update(delta: float):
	parent_node.velocity = Vector2.ZERO
	
func _on_animation_finished():
	if animated_sprite.animation.to_lower() == "death":
		if reset_scene:
			get_tree().reload_current_scene()
		else:
			parent_node.z_index = 4
	
