extends Node2D
const LASER = preload ("res://LaserBeam.tscn")
const SPEED = 10
const ROTATE_SPEED = 0.10
var timer
var bullet_delay = 0.15
var can_shoot = true
var ship
func _ready():
	ship = get_parent()

	timer = Timer.new()
	timer.set_wait_time( bullet_delay )
	timer.set_one_shot(true)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	pass

func on_timeout_complete():
	can_shoot = true
	

func _process(delta):
	var speed_y = 0
	if ship.playerCannon == 0:
		if Input.is_action_just_pressed("key_right"):
			rotation = rotation + ROTATE_SPEED
		elif Input.is_action_just_pressed("key_left"):
			rotation = rotation - ROTATE_SPEED
		if Input.is_action_just_pressed("ui_accept") && can_shoot:
			var laserbeam = LASER.instance()
			get_tree().get_root().add_child(laserbeam)
			laserbeam.position = $"Sprite/Position2D".global_position
			laserbeam.rotation = $"Sprite/Position2D".global_rotation
					
			can_shoot = false	
			
			get_node("AudioPlayer").play(0)
			
			timer.start()  
	if ship.playerCannon == 1:
		if Input.is_action_just_pressed("ui_right"):
			rotation = rotation + ROTATE_SPEED
		elif Input.is_action_just_pressed("ui_left"):
			rotation = rotation - ROTATE_SPEED
		if Input.is_action_just_pressed("ui_accept") && can_shoot:
			var laserbeam = LASER.instance()
			get_tree().get_root().add_child(laserbeam)
			laserbeam.position = $"Sprite/Position2D".global_position
			laserbeam.rotation = $"Sprite/Position2D".global_rotation
					
			can_shoot = false	
			
			get_node("AudioPlayer").play(0)
			
			timer.start()  
	if rotation > PI/2: rotation = PI/2
	if rotation < -PI/2: rotation = -PI/2
	
	var motion = Vector2(0, speed_y) * SPEED;
	translate(motion * delta)
		
	
		
	
		