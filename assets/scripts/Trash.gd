extends RigidBody2D

export (int) var MIN_SPEED =200# Minimum speed range.
export (int) var MAX_SPEED =300# Maximum speed range.

const NEGATIVE_RANGE = -200
const POSITIVE_RANGE = 200
var isBigTrash = false;

func _ready():
	var randX = range(NEGATIVE_RANGE,POSITIVE_RANGE)[randi()%range(NEGATIVE_RANGE,POSITIVE_RANGE).size()]
	var randY =	range(NEGATIVE_RANGE,POSITIVE_RANGE)[randi()%range(NEGATIVE_RANGE,POSITIVE_RANGE).size()]
	apply_impulse(Vector2(), Vector2(randX, randY))
	add_to_group("enemy")
	
func _on_Visibility_screen_exited():
    queue_free()


func _on_Trash_body_entered(body):
	if(body.is_in_group("Lazer") && isBigTrash):
		queue_free()
		
		
	
	if body.is_in_group("Ship") || body.is_in_group("Lazer"):
		queue_free()
		
