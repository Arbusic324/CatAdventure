extends RigidBody2D
@export var power_push:int
var colide = false
func _on_area_2d_area_entered(area):
	if colide:
		linear_velocity.x = power_push
		print("levo")
func _on_done_area_area_entered(area):
	if colide:
		linear_velocity.x = -1 * power_push 
		print("pravo")


func _on_area_detector_player_body_entered(body:CharacterBody2D):
	colide = true
func _on_area_detector_player_body_exited(body:CharacterBody2D):
	colide = false
