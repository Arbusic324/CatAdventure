extends AnimatableBody2D
@export var move_y:int
@export var n_p:int
@export var time_to_move:int
var time = 0
var moved_ = false
var pos_
var number_platform 
func _ready():
	$time_to_move.wait_time = time_to_move
	set_physics_process(false)
	number_platform = 0
	pos_ = global_position.y
func stop_platform():
	set_physics_process(false)
	if moved_:
		moved_ = false
	else:
		moved_ = true
func _physics_process(delta):
	if not moved_:
		if position.y > (pos_- move_y):
			position.y -= .5
		else:
			stop_platform()
	else:
		if position.y < pos_:
			position.y += .5
		else:
			stop_platform()
func _on_platform_toggle_n_p():
	number_platform +=1
func _on_platform_toggle_push_n_p():
	if number_platform == n_p:
		$time_to_move.start()
	number_platform = 0
	
func _on_time_to_move_timeout():
	set_physics_process(true)
