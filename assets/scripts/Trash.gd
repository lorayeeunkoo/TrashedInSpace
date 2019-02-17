extends RigidBody2D

export (int) var MIN_SPEED =200# Minimum speed range.
export (int) var MAX_SPEED =300# Maximum speed range.
var trash_types = ["right", "up"]
var is_hit=false
func _ready():
	add_to_group("enemy")
	$AnimatedSprite.animation = trash_types[randi() % trash_types.size()]
	
func _on_Visibility_screen_exited():
    queue_free()


func _on_Trash_body_entered(body):
	if body.is_in_group("Ship"):
		queue_free()
		
