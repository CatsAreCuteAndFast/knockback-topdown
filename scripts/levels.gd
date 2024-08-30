extends Node2D

var enemies_node : Node2D

func _ready() -> void:
	enemies_node = find_child("Enemies")

func _process(delta: float) -> void:
	if enemies_node.get_child_count() == 0:
		SceneTransition.change_scene("res://scenes/levels/level" + str(int(name.substr(5)) + 1) + ".tscn")
