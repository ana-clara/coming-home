extends Control

func _on_Yes_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_No_pressed():
	get_tree().change_scene("res://Prefabs/Menu.tscn")
