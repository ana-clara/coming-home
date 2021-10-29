extends Control

onready var anim = $Logo/AnimationPlayer

func _ready():
	$VBoxContainer/PlayButton.grab_focus()
	
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/ChooseAlien.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")
