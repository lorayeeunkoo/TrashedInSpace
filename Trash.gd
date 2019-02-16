extends RigidBody2D


export (int) var MIN_SPEED # Minimum speed range.
export (int) var MAX_SPEED # Maximum speed range.
var trash_types = ["right", "up"]

func _ready():
	$AnimatedSprite.animation = trash_types[randi() % trash_types.size()]

func _on_Visibility_screen_exited():
    queue_free()

