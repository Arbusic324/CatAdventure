extends Node2D
signal hud_plus
signal hud_sbros
var fail_time = false
var strike_count = 0
var UV = false
var head_idle_on = true
var idle = false
var jump_li = 0
var pos_active = false
var count_pos_luck = 0
var count_pos_fail = 0
var staired_li = false
var run
var stair_left = false
var stair_right = false
var live = true
var stage_rejevatorion = true
var stage_died = false
var stage_checkpoint = false
func _ready():
	head_idle_on = false
	idle = false
	jump_li = 0
	staired_li = false
	pos_active = false
func _on_player_cat_idle():
	idle = true
func _on_player_cat_run():
	run = true
	#########################################
func _on_player_cat_flip_h():
	UV = true
	$sprite_body.flip_h = true
	$sprite_head.flip_h = true
func _on_player_cat_flip_h__():
	UV = false
	$sprite_body.flip_h = false
	$sprite_head.flip_h = false
func _on_player_cat_rotate_normal():
	stair_left = false
	stair_right = false
func _on_player_cat_rotate_left():
	stair_left = false
	stair_right = true
func _on_player_cat_rotate_right():
	stair_left = true
	stair_right = false
	###################################################
func _on_time_for_head_timeout():
	pass
func _on_player_cat_jump_anim():
	jump_li = 1
func _on_player_cat_jump_move_anim():
	jump_li = 2
func _on_player_cat_jump_anim_off():
	jump_li = 0
func _on_player_cat_stair_ed():
	staired_li = true
func _on_player_cat_not_stair_ed():
	staired_li = false
func _on_player_cat_update_anim():
	if stair_left == true and stair_right == true:
		$sprite_body.offset.x = 0
		$sprite_head.offset.x = 0
	if pos_active == false and fail_time == false and live == true:
		if idle == true and run == false:
			if stage_checkpoint:
				$Animation_head.play("Check_point")
			else:
				$Animation_head.play("Idle")
			if staired_li:
				$Animation_body.play("stair_idle")
				if stair_right:
					if UV:
						$sprite_body.offset.x = 16
						$sprite_head.offset.x = 16
					else:
						$sprite_body.offset.x = 0
						$sprite_head.offset.x = 0
				elif stair_left:
					if UV:
						$sprite_body.offset.x = 0
						$sprite_head.offset.x = 0
					else:
						$sprite_body.offset.x = -16
						$sprite_head.offset.x = -16
			else:
				if stage_checkpoint:
					$Animation_body.play("Check_point")
				else:
					$Animation_body.play("idle")
		elif idle == false and run == true and jump_li == 0:
			if staired_li == false:
				$Animation_body.play("walk")
				$Animation_head.play("walk")
			else:
				$Animation_body.play("walk_stair")
				$Animation_head.play("walk_stair")
		if jump_li !=0:
			if jump_li == 1:
				$Animation_body.play("jump")
				$Animation_head.play("jump")
			elif jump_li == 2:
				$Animation_body.play("fall")
				$Animation_head.play("fall")
	elif fail_time:
		$Animation_body.play("fail_int")
		$Animation_head.play("fail_int")
func _on_player_cat_not_idle():
	idle = false
func _on_player_cat_not_run():
	run = false


func _on_player_cat_luck():
	strike_count += 1
	count_pos_luck = randi_range(-1,1)
	if strike_count > 5:
		pos_active = true
		$Time_to_stop_pos.start()
		if count_pos_luck < 0:
			$Animation_body.play("one_jojoPOS")
			$Animation_head.play("one_jojoPOS")
		elif count_pos_luck == 0:
			$Animation_body.play("two_jojoPOS")
			$Animation_head.play("two_jojoPOS")
		elif count_pos_luck > 0:
			$Animation_body.play("three jojoPOS")
			$Animation_head.play("three jojoPOS")
func _on_player_cat_fail():
	fail_time = true
	$Time_to_stop_fail_animate.start()
	strike_count = 0
	count_pos_fail = randi_range(-1,1)
func _on_time_to_stop_pos_timeout():
	pos_active = false

func _on_time_to_stop_fail_animate_timeout():
	fail_time = false
	print("stop_dail")


func _on_player_cat_camera_back():
	live = true
	stage_died = false
	stage_rejevatorion = true
	if stage_rejevatorion:
		$time_to_redeem.start()
		$Animation_body.play("redeem")
		$Animation_head.play("redeem")
		stage_rejevatorion = false
func _on_player_cat_camera_ded():
	live = false
	$sprite_body.position = Vector2(0,3)
	$sprite_head.position = Vector2(0,3.15)
	$Animation_body.speed_scale = 0.5
	$Animation_head.speed_scale = 0.5
	if stage_died == false:
		stage_died = true
		$Time_to_die_anima.start()
func _on_time_to_die_anima_timeout():
	if stage_died:
		$Animation_body.play("DIE")
		$Animation_head.play("DIE")
func _on_time_to_redeem_timeout():
	$sprite_body.position = Vector2(0,2.4)
	$sprite_head.position = Vector2(0,2.75)
	$Animation_body.speed_scale = 1
	$Animation_head.speed_scale = 1
func _on_player_cat_new_checkpoint():
	stage_checkpoint = true
	$Time_stage_checkpoint.start()

func _on_time_stage_checkpoint_timeout():
	stage_checkpoint = false
