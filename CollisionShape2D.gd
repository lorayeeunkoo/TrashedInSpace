extends CollisionShape2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var opacity_begin_effect
var opacity_end_effect

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_spaceStation_body_entered(body):
	# begin to shade away
	opacity_begin_effect = Tween.new()
	opacity_begin_effect.interpolate_property($Sprite, "modulate", 
      Color(1, 1, 1, 1), Color(0, 0, 0, 0), 2.0, 
      Tween.TRANS_LINEAR, Tween.EASE_IN)
	

func _on_spaceStation_body_exited(body):
	#finish shading away into full dark
	opacity_end_effect = Tween.new()
	opacity_end_effect.interpolate_property($Sprite, "modulate", 
      Color(1, 1, 1, 0.5), Color(1, 1, 1, 0), 2.0, 
      Tween.TRANS_LINEAR, Tween.EASE_IN)
