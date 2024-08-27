extends State
class_name PlayerIdle

@export var animated_sprite : AnimatedSprite2D

func Enter():
	animated_sprite.play("idle")
