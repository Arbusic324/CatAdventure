extends Camera2D
var rotate = 0
var pos_y = 0
var pos_uv = 1
var rotate_uv = false
var max_rotate = 19
var speed_rotate = 2.5
var live = true
func _process(delta):
	if live == true:
		if zoom > Vector2(7,7):
			zoom -= Vector2(0.05,0.05)
		if zoom < Vector2(7,7):
			zoom += Vector2(0.05,0.05)
		if rotate > 0:
			rotate = rotate - 1
		if rotate < 0:
			rotate = rotate + 1
	if live == false:
		if zoom < Vector2(10,10):
			zoom += Vector2(0.05,0.05)
		if rotate > 0:
			rotate -= 1
		elif rotate < 0:
			rotate += 1
		if position.y < -20 and pos_uv > 0:
			pos_uv = -1
			pos_y = 0
		if position.y > 20 and pos_uv < 0:
			pos_uv = 1
			pos_y = 0
		if pos_uv > 0:
			position.y -=pos_y
			pos_y = min(pos_y + 0.01, 0.3)
		if pos_uv < 0:
			position.y +=pos_y
			pos_y = min(pos_y + 0.01, 0.3)
			#if x_input > 0: 
			#	velocity.x = min(velocity.x + A, speed)
			#elif x_input < 0:
			#	velocity.x = max(velocity.x - A, -speed)
	rotation_degrees = rotate
func _on_player_cat_fail():
	if live == true:
		zoom = Vector2(7.4,7.4)
		pos_y = 10
		rotate_uv = randi_range(false, true)
		if rotate_uv:
			rotate = randi_range(19,5)
		else:
			rotate = randi_range(-19,-5)

func _on_player_cat_luck():
	if live == true:
		zoom = Vector2(7.4,7.4)

func _on_player_cat_camera_back():
	position_smoothing_enabled = false
	$Timer.start()
func _on_player_cat_camera_ded():
	live = false

func _on_timer_timeout():
	pos_y = 0
	position = Vector2(0,0)
	live = true
	position_smoothing_enabled = true

func _on_player_cat_tact():
	if live == true:
		zoom = Vector2(7.5,7.5)
