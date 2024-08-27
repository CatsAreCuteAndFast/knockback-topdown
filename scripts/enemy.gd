extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var killzone: Area2D = $Killzone
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _physics_process(_delta: float) -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
	move_and_slide()


func _on_health_on_death() -> void:
	state_machine.change_state("Death")
	killzone.queue_free()
	collision_shape_2d.queue_free()
	
