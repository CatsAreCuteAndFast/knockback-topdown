extends CanvasLayer

var new_scene_string = ""
var level = 0

@onready var animation_player = $AnimationPlayer

func change_scene(new_scene: String):
	new_scene_string = new_scene
	animation_player.play("dissolve")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dissolve":
		get_tree().change_scene_to_file(new_scene_string)
		animation_player.play("undesolve")
