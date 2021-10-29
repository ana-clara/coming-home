extends KinematicBody2D

var motion = Vector2.ZERO
var dead = false
const GRAV = 600

func _on_Area2D_area_entered(area):
	if not dead:
		motion.y = -600

func _physics_process(delta):
	motion.y += GRAV * delta
	$AnimatedSprite.flip_v = motion.y > 0
	motion = move_and_slide(motion, Vector2.UP)
