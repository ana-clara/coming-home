extends KinematicBody2D

enum State {alive, dead}

const ACC = 700
const FRIC = 0.4
const MAXSPEED = 500
const GRAV = 50
const JUMP = -1000
onready var COLOR = Global.color

var state = State.alive
export var keys = 0
var jumped = false
var motion = Vector2.ZERO
onready var anim = $AnimatedSprite/AnimationPlayer

signal life_changed
signal keys_changed(keys)
signal color(color)

func _ready():
	emit_signal("color", COLOR)
	emit_signal("keys_changed", keys)

func _physics_process(delta):
	
	if Global.lives <= 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		Global.lives = 5
	
	if is_on_floor() and state == State.alive:
		if jumped:
			jumped = false
			
		if Input.is_action_pressed("move_jump"):
			jump()
			
	else:
		if Input.is_action_pressed("move_jump"):
			motion.y += GRAV / 2
			
		else:
			motion.y += GRAV
	
	if state == State.alive:
		
		var input = Input.get_action_strength("move_right") -\
					Input.get_action_strength("move_left")
					
		if input:
			motion.x += input * ACC * delta
			
		elif sign(input) != sign(motion.x):
			motion.x = lerp(motion.x, 0, FRIC)
			
		if not jumped:
		
			if abs(motion.x) > 0.5:
				anim.play("walk_" + COLOR)
				$AnimatedSprite.flip_h = motion.x < 0
				
			else:
				motion.x = 0
				anim.play("idle_" + COLOR)
	
	elif state == State.dead:
		if global_position.y > get_node("Camera2D").limit_bottom:
			get_tree().reload_current_scene()
		
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	motion = move_and_slide(motion, Vector2.UP)

func _on_KeyPicker_body_entered(body):
	if body is TileMap:
		if body.name == "KeyMap":
			keys += 1
			emit_signal("keys_changed", keys)
		elif body.name == "HeartMap":
			Global.lives += 1
			emit_signal("life_changed")
		var x = global_position.x / body.cell_size.x
		var y = global_position.y / body.cell_size.y
		
		body.set_cell(x, y, -1)
		body.set_cell(x - 1, y, -1)
		body.set_cell(x + 1, y, -1)
		body.set_cell(x, y - 1, -1)
		body.set_cell(x - 1, y - 1, -1)
		body.set_cell(x + 1, y - 1, -1)
		body.set_cell(x + 1, y + 1, -1)
		body.set_cell(x - 1, y + 1, -1)
		body.update_dirty_quadrants()

func die():
	state = State.dead
	Global.lives -= 1
	anim.play("hurt_" + COLOR)
	z_index = 10
	$CollisionShape2D.queue_free()
	motion.x = 0
	motion.y = JUMP / 2
	
func jump():
	jumped = true
	motion.y = JUMP
	anim.play("jump_" + COLOR)

func _on_Water_body_entered(body):
	if body == self and state != State.dead:
		die()

func _on_Keyring_body_entered(body):
	if keys > 0 and body is TileMap:
		keys -= 1
		emit_signal("keys_changed", keys)
		var x = global_position.x / body.cell_size.x
		var y = global_position.y / body.cell_size.y
		
		body.set_cell(x, y, -1)
		body.set_cell(x - 1, y, -1)
		body.set_cell(x + 1, y, -1)
		body.set_cell(x, y - 1, -1)
		body.set_cell(x - 1, y - 1, -1)
		body.set_cell(x + 1, y - 1, -1)
		body.set_cell(x + 1, y + 1, -1)
		body.set_cell(x - 1, y + 1, -1)
		body.update_dirty_quadrants()
