extends RigidBody2D

const LASER_SPEED = 500;

func _ready():
	add_to_group("Lazer")
	pass

func _process(delta):
	var speed_x = 1;
	var speed_y = 0;
	var motion = (Vector2(speed_x, speed_y) * LASER_SPEED).rotated(rotation);
	translate(motion * delta)



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_LaserBeam_body_entered(body):
	if body.is_in_group("Ship"):
		queue_free()
