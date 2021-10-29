extends KinematicBody2D

onready var anim = $AnimatedSprite/AnimationPlayer
var direction = Vector2.LEFT
var dead = false
export var SPEED = 2000

func _on_WalkSensor_body_entered(body):
	invert(body)
		
func invert(body):
	if body is TileMap:
		direction.x *= -1
		
func _physics_process(delta):
	if not dead:
		anim.playback_speed = 0.3
		anim.play("walk")
		$AnimatedSprite.flip_h = direction.x > 0
		$Sensors.scale.x = -direction.x
		move_and_slide(direction * SPEED * delta + Vector2.DOWN * 20, Vector2.UP)

func _on_FallSensor_body_exited(body):
	invert(body)
