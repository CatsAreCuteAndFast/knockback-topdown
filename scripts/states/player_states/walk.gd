extends State
class_name PlayerWalk

@export var animated_sprite : AnimatedSprite2D

func Enter():
	animated_sprite.play("walk")
