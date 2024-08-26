extends State
class_name Death

@export var reset_scene = false
@export var parent_node : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D

func Enter():
	animated_sprite.play("death")
	animated_sprite.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished():
	if reset_scene:
		get_tree().reload_current_scene()
	else:
		parent_node.queue_free()
	
