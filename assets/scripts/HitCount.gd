extends CanvasLayer

#const FUEL_SCENE = preload("res://Fuel.tscn")
#var fuel
var ship
var hitCount
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	hitCount = $"HitCount"
#	fuel = FUEL_SCENE.instance()
#	add_child(fuel)
	ship = $"../ship"
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):	
	hitCount.text = "Fuel: " + str(int(ship.fuel))
	
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
