extends State
class_name PlayerIdle

@export var character_body : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D

func Enter():
	animated_sprite.play("idle")
	
func Update(delta):
	if character_body.velocity.x != 0 or character_body.velocity.y != 0:
		Transitioned.emit(self, "PlayerWalk")


func _on_health_on_death() -> void:
	Transitioned.emit(self, "Death")
