extends CharacterBody2D
var uv = 0
var touch = false
func _on_area_2d_area_entered(area):
	uv = 1 # levo
func _on_done_area_area_entered(area):
	uv = -1 # pravo
func _on_area_detector_player_body_entered(body:CharacterBody2D):
	touch = true
	set_physics_process(true)
func _on_area_detector_player_body_exited(body:CharacterBody2D):
	uv = 0
	touch = false
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += 9.8
	if is_on_floor() and touch == false:
		set_physics_process(false)
	velocity.x = 20 * uv
	move_and_slide()
func _on_timer_timeout():
	set_physics_process(false)
func _on_area_2d_area_exited(area):
	uv = 0
func _on_done_area_area_exited(area):
	uv = 0
