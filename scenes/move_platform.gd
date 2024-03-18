extends AnimatableBody2D
@export var move_x:int
@export var move_y:int
@export var n_p:int
@export var time_to_move:int
@export var velocity_plat_x:float
@export var velocity_plat_y:float
var time = 0
var moved_ = false
var pos_y
var pos_x
var number_platform 
var complited = [false,false]
func _ready():
	$time_to_move.wait_time = time_to_move
	set_physics_process(false)
	number_platform = 0
	pos_y = global_position.y
	pos_x = global_position.x
func stop_platform():
	set_physics_process(false)
	if moved_:
		moved_ = false
	else:
		moved_ = true
func _physics_process(delta):
	if complited[0] == true and complited[1] == true:
		complited[1] = false
		complited[0] = false
		print("che")
		stop_platform()
	if not moved_:
		if move_x != 0: 
			if position.x < (pos_x + move_x):
				position.x += velocity_plat_x
			else:
				complited[0] = true
		else:
			complited[0] = true
		if move_y != 0:
			if position.y > (pos_y - move_y):
				position.y -= velocity_plat_y
			else:
				complited[1] = true
		else:
			complited[1] = true
	else:
		if move_x != 0:
			if position.x > pos_x:
				position.x -= velocity_plat_x
			else:
				complited[0] = true
		else:
			complited[0] = true
		if move_y != 0:
			if position.y < pos_y:
				position.y += velocity_plat_y
			else:
				complited[1] = true
		else:
			complited[1] = true
func _on_platform_toggle_n_p():
	number_platform +=1
func _on_platform_toggle_push_n_p():
	if number_platform == n_p:
		$time_to_move.start()
	number_platform = 0
	
func _on_time_to_move_timeout():
	set_physics_process(true)
