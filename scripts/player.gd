extends CharacterBody2D

@onready var state_machine: StateMachine = $StateMachine

@export var speed: float = 100
@export var accel: float = 10
@export var animated_sprite : AnimatedSprite2D

var dead = false

func _process(_delta: float) -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
		
	if not dead:
		if Input.is_action_pressed("left_click"):
			state_machine.change_state("BigBowAttack")
		elif velocity.x != 0 or velocity.y != 0:
			state_machine.change_state("PlayerWalk")
		elif velocity.x == 0 and velocity.y == 0:
			state_machine.change_state("PlayerIdle")
		

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	
func _on_health_on_death() -> void:
	speed = 0
	dead = true
	state_machine.change_state("Death")
