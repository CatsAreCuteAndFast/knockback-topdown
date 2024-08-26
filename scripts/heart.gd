extends TextureRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _is_visible = true

func hide_heart():
	if _is_visible:
		animation_player.play("flicker")
		_is_visible = false
	
func reveal_heart():
	if not _is_visible:
		animation_player.play("RESET")
