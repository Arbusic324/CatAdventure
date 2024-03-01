extends Node2D
signal touched_slow_trap
signal no_touched_slow_trap
func _on_area_2d_body_entered(body: PhysicsBody2D):
	emit_signal("touched_slow_trap")

func _on_area_2d_body_exited(body: PhysicsBody2D):
	emit_signal("no_touched_slow_trap")
