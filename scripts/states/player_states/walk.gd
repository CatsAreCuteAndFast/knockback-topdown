extends State
class_name PlayerWalk

@export var character_body : CharacterBody2D
@export var animated_sprite : AnimatedSprite2D

func Enter():
	animated_sprite.play("walk")
	
func Update(_delta):
	if character_body.velocity.x == 0 and character_body.velocity.y == 0:
		Transitioned.emit(self, "PlayerIdle")


func _on_health_on_death() -> void:
	Transitioned.emit(self, "Death")
