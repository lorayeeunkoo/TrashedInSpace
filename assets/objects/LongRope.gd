extends Node2D

var PIECE = preload("res://assets/objects/Link.tscn")
var BALL = preload("res://assets/objects/Ball.tscn")

export (int) var pieces = 10
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var parent = $Anchor
	for i in range (pieces):
		parent = addPiece(parent)
	parent = addBall(parent)
	
func addPiece(parent):
	var joint = parent.get_node("CollisionShape2D/Joint")
	var piece = PIECE.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece
	
func addBall(parent):
	var joint = parent.get_node("CollisionShape2D/Joint")
	var piece = BALL.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
