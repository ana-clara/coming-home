extends Control

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Prefabs/Menu.tscn")
