extends Node2D
signal UP_bonus_touch
signal UP_bonus_not_touch
func _on_area_2d_body_entered(body: PhysicsBody2D):
	emit_signal("UP_bonus_touch")
func _on_area_2d_body_exited(body: PhysicsBody2D):
	emit_signal("UP_bonus_not_touch")
