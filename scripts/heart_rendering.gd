extends Control

@export var heart_scene: PackedScene
@export var original_heart_pos = Vector2(30, 30)
@export var heart_spacing = Vector2(100, 0)
@export var health_script : Health

var hearts = []

func _ready():
	# Create hearts equal to max health
	for i in range(health_script.max_health):
		var heart = heart_scene.instantiate()
		heart.position = Vector2(i * heart_spacing[0] + original_heart_pos[0], i * heart_spacing[1] + original_heart_pos[1])
		add_child(heart)
		hearts.append(heart)
	
	# Initial update of hearts
	update_hearts(health_script.current_health)

func _on_health_changed(new_health):
	update_hearts(new_health)

func update_hearts(current_health):
	for i in range(hearts.size()):
		if i < current_health:
			hearts[i].reveal_heart()
		else:
			hearts[i].hide_heart()
