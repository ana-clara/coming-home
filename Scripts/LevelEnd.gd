extends Area2D

export (String, FILE, "*.tscn") var proximo_level

func _on_LevelEnd_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(proximo_level)
