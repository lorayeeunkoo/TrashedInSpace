extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var no_opacity_effect

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_as_toplevel(true)
	$CollisionShape2D/Sprite.self_modulate = Color(0, 0, 1)
#	no_opacity_effect = Tween.new()
#	no_opacity_effect.interpolate_property($CollisionShape2D/Sprite, "modulate", 
#      Color(1, 1, 1, 1), Color(1, 1, 1, 1), 2.0, 
#      Tween.TRANS_LINEAR, Tween.EASE_IN)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass