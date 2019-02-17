extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(Input.is_action_pressed('ui_accept')):
		var col = get_overlapping_bodies()
		for body in col:
			if body.is_in_group('enemy'):
				var delta_pos = global_position - body.global_position
				var normal_delta_pos = delta_pos.normalized()
				var size = $CollisionShape2D.shape.radius / Vector2().distance_to(delta_pos)
				normal_delta_pos = normal_delta_pos * size
				body.apply_impulse(Vector2(), normal_delta_pos)
		print(col.size())
		