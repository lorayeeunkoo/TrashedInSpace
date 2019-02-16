extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var PIECE = preload("res://Piece.tscn")
var BALL = preload("res://Ball.tscn")

export (int) var pieces = 40

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var parent = $Sprite/Anchor
	for i in range (pieces):
		parent = addPiece(parent)
	addBall(parent)
		
func addPiece(parent):
	var joint = parent.get_node("CollisionShape2D/Joint")
	var piece = PIECE.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece
	
func addBall(parent):
	var joint = parent.get_node("CollisionShape2D/Joint")
	var ball = BALL.instance()
	joint.add_child(ball)
	joint.node_a = parent.get_path()
	joint.node_b = ball.get_path()
	return ball

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	for i in range (pieces):
		pass
#	pass
