extends Control

func _on_Green_pressed():
	Global.color = "green"
	game_on()

func _on_Blue_pressed():
	Global.color = "blue"
	game_on()

func _on_Pink_pressed():
	Global.color = "pink"
	game_on()

func _on_Beige_pressed():
	Global.color = "beige"
	game_on()

func game_on():
	get_tree().change_scene("res://Scenes/World.tscn")
