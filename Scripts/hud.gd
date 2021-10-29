extends Control

const colors = ["beige", "blue", "green", "pink"]
var badges = {}
onready var tex = $MarginContainer/HBoxContainer/HSplitContainer/TextureRect
onready var life_counter = $MarginContainer/HBoxContainer/HSplitContainer/Label
onready var key_counter = $MarginContainer/HBoxContainer/HSplitContainer2/Label

func _ready():
	
	for color in colors:
		badges[color] = load("res://Assets/moreenemiesanimation/Alien sprites/alien"+ color.capitalize() +"_badge1.png")
	
	life_counter.text = str(Global.lives)
		
func setCharacter(color):
	tex.texture = badges[color]

func _on_Player_color(color):
	setCharacter(color)

func _on_Player_keys_changed(keys):
	key_counter.text = str(keys)

func _on_Player_life_changed():
	life_counter.text = str(Global.lives)	
