extends Node2D
signal one_n
signal two_n
signal one_f
signal two_f
var one
var two
func _process(delta):
	if $RayCast2D.is_colliding() == true:
		one = true
		emit_signal("one_n")
	elif $RayCast2D.is_colliding() == false:
		one = false
		emit_signal("one_f")
	if $RayCast2D2.is_colliding() == true:
		two = true
		emit_signal("two_n")
	elif $RayCast2D2.is_colliding() == false:
		two = false
		emit_signal("two_f")
