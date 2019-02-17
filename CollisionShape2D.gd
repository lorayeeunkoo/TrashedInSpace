extends CollisionShape2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var no_opacity_effect
var opacity_begin_effect
var opacity_end_effect

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	no_opacity_effect = Tween.new()
#	no_opacity_effect.interpolate_property($Sprite, "modulate", 
#      Color(1, 1, 1, 1), Color(1, 1, 1, 1), 2.0, 
#      Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Sprite.self_modulate = Color(0, 0, 1)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_spaceStation_body_entered(body):
	# begin to shade away
	$Sprite.self_modulate = Color(0, 1, 0)
#	opacity_begin_effect = Tween.new()
#	opacity_begin_effect.interpolate_property($Sprite, "modulate", 
#      Color(1, 1, 1, 1), Color(1, 1, 1, 0.5), 2.0, 
#      Tween.TRANS_LINEAR, Tween.EASE_IN)
	body.spaceStationEntered()
	

func _on_spaceStation_body_exited(body):
	#finish shading away into full dark
	$Sprite.self_modulate = Color(1, 0, 0)
#	opacity_end_effect = Tween.new()
#	opacity_end_effect.interpolate_property($Sprite, "modulate", 
#      Color(1, 1, 1, 0.5), Color(1, 1, 1, 0), 2.0, 
#      Tween.TRANS_LINEAR, Tween.EASE_IN)
