extends CharacterBody2D


@export var speed: float = 100
@export var accel: float = 10
@export var animated_sprite : AnimatedSprite2D

func _process(_delta: float) -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	


func _on_health_on_death() -> void:
	speed = 0
