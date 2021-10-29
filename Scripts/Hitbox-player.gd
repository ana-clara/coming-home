extends Area2D

onready var player = $".."

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		var anim = body.get_node("AnimatedSprite/AnimationPlayer")
		body.get_node("Hitbox/CollisionShape2D").queue_free()
		body.get_node("CollisionShape2D").queue_free()
		body.dead = true
		
		player.jump()
		
		anim.play("dead")
		yield(anim, "animation_finished")
		body.queue_free()
		
