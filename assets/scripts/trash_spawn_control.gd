extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var ship
var lastQuad = Vector2()
var location_history = {}
var quad_size = 7500
var amount = 25 # number of tries of random

var preScript = preload("res://assets/scripts/SoftNoise.gd")

var appleSmall = preload("res://appleEye.tscn")
var trashTwo = preload("res://TrashTwo.tscn")
var trashThree = preload("res://TrashThree.tscn")
var trashFour = preload("res://TrashFour.tscn")
var trashFive = preload("res://TrashFive.tscn")
var trashSix = preload("res://TrashSix.tscn")






var trashArray = [appleSmall, trashTwo, trashThree, trashFour, trashFive, trashSix]


func _ready():
	ship = $"../ship"

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	var quad = ship.global_position/quad_size
	quad.x = floor(quad.x)
	quad.y = floor(quad.y)
	if lastQuad != quad:
		print("stuff")
		spawn_trash(Vector2(quad.x+1,quad.y))
		spawn_trash(Vector2(quad.x+1,quad.y+1))
		spawn_trash(Vector2(quad.x,quad.y+1))
		spawn_trash(Vector2(quad.x-1,quad.y))
		spawn_trash(Vector2(quad.x-1,quad.y-1))
		spawn_trash(Vector2(quad.x,quad.y-1))
		spawn_trash(Vector2(quad.x-1,quad.y+1))
		spawn_trash(Vector2(quad.x+1,quad.y-1))
		lastQuad = quad

func spawn_trash(quad): 
	
	var key = str(quad.x)+','+str(quad.y)
	var first_time = false
	if !location_history.has(key):
		location_history[key] = OS.get_unix_time()
		first_time = true
	
	if  OS.get_unix_time() - location_history[key] > 60 || first_time :
		var softnoise = preScript.SoftNoise.new()
		for i in range(amount):
			var rand_loc = Vector2(rand_range(0,quad_size),rand_range(0,quad_size))
			
			var noise = softnoise.simple_noise2d(rand_loc.x, rand_loc.y)
			
			if noise > 0:
				var randomNumber = randi() % trashArray.size()
				var trash = trashArray[randomNumber].instance()
				trash.position = rand_loc + quad * quad_size
				if randomNumber == 3:
					trash.isBigTrash = true;
				add_child(trash)
		
		