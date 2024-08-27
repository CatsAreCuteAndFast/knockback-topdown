extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var topright: RayCast2D = $"8DirectionalRaycasts/topright"
@onready var topleft: RayCast2D = $"8DirectionalRaycasts/topleft"
@onready var bottomleft: RayCast2D = $"8DirectionalRaycasts/bottomleft"
@onready var bottomright: RayCast2D = $"8DirectionalRaycasts/bottomright"
@onready var bottom: RayCast2D = $"8DirectionalRaycasts/bottom"
@onready var top: RayCast2D = $"8DirectionalRaycasts/top"
@onready var left: RayCast2D = $"8DirectionalRaycasts/left"
@onready var right: RayCast2D = $"8DirectionalRaycasts/right"

var raycast_array : Array

func _ready() -> void:
	raycast_array = [topright, topleft, bottomright, bottomleft, left, right, top, bottom]

func _physics_process(_delta: float) -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
	move_and_slide()
