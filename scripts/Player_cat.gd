extends CharacterBody2D	
#############################################################  КОСТЫЛЬ для UP bonus с багом collison_mask_value(1,1)
var int_li = false ################# Отложено
######################################### HUD AND INVENTORY ####################
signal eated # FOOOOODDDDDDDDDDDD
signal Take_damage
signal Heart_bonus
signal ritm_on
signal ritm_off
signal interaction
signal int_heart
############################# ANIMATION
signal new_checkpoint
signal int_botl_1
signal Idle
signal not_idle
signal not_run
signal Run 
signal stair_ed
signal not_stair_ed
signal jump_anim_off 
signal jump_anim         ################### возвышение
signal jump_move_anim ################# падение
signal Flip_h
signal Flip_h__
signal Rotate_right
signal Rotate_left
signal Rotate_normal
signal Update_anim
signal tact
########################
var quality_count = 0
var quality_pos_x = 0
var quality_pos_r = 0
var quality_text_active = false
var HP_bar = false #ВКЛЮЧЕНИЕ ПОЛОС СЕРДЕЦ
var HP = 3
var ready_take_damage = true
var redeem = false
var RITM = false
var stuck_proverka_ = false ##################### ЗАСТРЕВАНИЕ В АП БОНУСАХ
var can_to_do_act = true
var ritm_started = false ################### включение выключение худа ритма и РИТМА от НЕГО
var can_make_checkpoint = false
#########################################################
var x_input = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 100
var jump = 180
var checkpoint_pos
var move = true
var Up_bonus = false
var checkpoint_number = 0
################################### CAMERA
signal camera_back
signal camera_ded
signal luck
signal fail
#################################### HORIZ STAIR ####################
var procces_vzbiranyia_start = false
var s_lest = false
var po_lest = false
var x_input_uv = true
var contr_1_touch = false
var contr_2_touch = false
#####################################################################
func heal():
	if HP <3:
		emit_signal("eated")
		emit_signal("Heart_bonus")
		HP +=1
func _ready():
	checkpoint_pos = global_position
	########################################### HUD################
	#############################################################3
	
func _physics_process(delta):
	if can_make_checkpoint and Input.is_action_just_pressed("RESET") and HP > 0:
		checkpoint_number +=1
		if checkpoint_number > 0:
			if x_input < 0:
				emit_signal("Flip_h")
			elif x_input > 0:
				emit_signal("Flip_h__")
			emit_signal("int_botl_1")
		emit_signal("new_checkpoint")
		can_make_checkpoint = false
	if quality_count !=0:
		if quality_text_active:
			if quality_pos_r == 0:
				$quality_tap/quality_text.rotation_degrees = 25
			elif quality_pos_r == 1:
				$quality_tap/quality_text.rotation_degrees = -25
			elif quality_pos_r == 2:
				$quality_tap/quality_text.rotation_degrees = 0
			if quality_pos_x == 1:
				$quality_tap/quality_text.position = Vector2(-6,-3)
			else:
				$quality_tap/quality_text.position = Vector2(6,-3)
			quality_text_active = false
		if quality_count == 1:
			$quality_tap/quality_text/AnimationPlayer.play("perfect")
		elif quality_count == 2:
			$quality_tap/quality_text/AnimationPlayer.play("good")
		elif quality_count == 3:
			$quality_tap/quality_text/AnimationPlayer.play("bad")
		elif  quality_count == 4:
			$quality_tap/quality_text/AnimationPlayer.play("fail")
		$quality_tap/quality_text.position += Vector2(0,-.5)
	else:
		$quality_tap/quality_text/AnimationPlayer.play("new_animation")
	if velocity.x == 0 and velocity.y == 0:
		emit_signal("Idle")
		emit_signal("not_run")
	elif velocity.x !=0:
		emit_signal("not_idle")
		emit_signal("Run")
	if move == true:
		emit_signal("Update_anim")
	if po_lest == true or s_lest == true:
		emit_signal("stair_ed")
	elif po_lest == false and s_lest == false:
		emit_signal("not_stair_ed")
	if stuck_proverka_ == true:
		set_collision_mask_value(1,0)
	if x_input > 0:
		x_input_uv = true
	elif x_input < 0:
		x_input_uv = false
	if contr_1_touch == false and contr_2_touch == false:
		s_lest = false
		po_lest = false
		emit_signal("Rotate_normal")
	if x_input_uv == true:
		if contr_2_touch == true and contr_1_touch == false:
			s_lest = true
			po_lest = false
		if contr_2_touch == false and contr_1_touch == true:
			po_lest = true
			s_lest = false
		if po_lest == true:
			emit_signal("Rotate_left")
		if s_lest == true:
			emit_signal("Rotate_right")
	elif x_input_uv == false:
		if contr_2_touch == true and contr_1_touch == false:
			po_lest = true
			s_lest = false
		if contr_1_touch == true and contr_2_touch == false:
			po_lest = false
			s_lest = true
		if po_lest == true:
			emit_signal("Rotate_right")
		if s_lest == true:
			emit_signal("Rotate_left")
	if not is_on_floor() and velocity.y < 0:
		if contr_1_touch == false or contr_2_touch == false:
			emit_signal("jump_anim")
	elif not is_on_floor() and velocity.y > 0:
		if contr_1_touch == false or contr_2_touch == false:
			emit_signal("jump_move_anim")
	if is_on_floor():
		emit_signal("jump_anim_off")
		if stuck_proverka_ == true:
			stuck_proverka_ == false
			#set_collision_mask_value(1,1)
		can_to_do_act = true
		int_li = false
	##################################################### ВЫВОД ИНФЫ В КОСНОЛЬ
	if Input.is_action_just_pressed("ui_accept"):
		print(checkpoint_number)
		pass
	###################################################### ON OR OFF RITM
	if Input.is_action_just_pressed("Ritm_start") and ritm_started == false:
		ritm_started = true
		emit_signal("ritm_on")
	if (Input.is_action_just_pressed("Ritm_Stop") and ritm_started == true) or HP < 1:
		ritm_started = false
		emit_signal("ritm_off")
	##################################################### ЕБАНЙ РИТМ,..
	if Up_bonus:
		if Input.is_action_just_pressed("interaction"):
			if can_to_do_act == true:
				can_to_do_act = false
				emit_signal("interaction")
				###########################################
		if RITM == true:
			RITM = false
			$interaction_luck.play()
			set_collision_mask_value(1,0)
			velocity.y = -jump * 1.62
		######################################################
	if checkpoint_number == 1:
		checkpoint_pos = Vector2(232, -40)
	x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if move:
		velocity.x = speed * x_input
	if HP < 1:
		emit_signal("camera_ded")
		velocity.x = 0
	if x_input > 0 and move:
		emit_signal("Flip_h__")
	elif x_input < 0 and move:
		emit_signal("Flip_h")
	if (not is_on_floor() and move == true) or HP < 1:
		if contr_1_touch == false and contr_2_touch == false:
			velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("ui_up") and move == true:
			velocity.y = -jump
	move_and_slide()

func _on_trap_slow_no_touched_slow_trap():
	speed = 100
func _on_trap_slow_touched_slow_trap():
	speed = 30

func _process(delta):
	if HP == 0 and redeem == false:
		move = false
		if Input.is_action_just_pressed("RESET"):
			redeem = true
			$Time_to_redeem.start()
	if Input.is_action_just_pressed("Take_damage"):
		if HP > 0 and ready_take_damage == true:
			ready_take_damage = false
			$Time_to_next_damage.start()
			HP = HP - 1
			emit_signal("Take_damage")
func _on_time_to_next_damage_timeout():
	ready_take_damage = true

func _on_time_to_redeem_timeout():
	emit_signal("int_heart")
	$PRe_redeem.start()
	redeem = false
	HP = 3
	position = checkpoint_pos
	emit_signal("camera_back")
func _on_p_re_redeem_timeout():
	move = true


func _on_up_bonus_up_bonus_not_touch():
	Up_bonus = false
	RITM = false
	$Proverka_stuck_li.is_stopped()
	set_collision_mask_value(1,1)
func _on_up_bonus_up_bonus_touch():
	if ritm_started:
		$Proverka_stuck_li.start()
		Up_bonus = true


#func _on_up_bonus_2_up_bonus_not_touch():
#	Up_bonus = false
#	set_collision_mask_value(1,1)
#func _on_up_bonus_2_up_bonus_touch():
#	if ritm_started:
#		Up_bonus = true

######################################## HOZ STAIRS####
func _on_ray_cast_one_f():
	contr_1_touch = false
func _on_ray_cast_one_n():
	contr_1_touch = true
func _on_ray_cast_two_f():
	contr_2_touch = false
func _on_ray_cast_two_n():
	contr_2_touch = true


func _on_proverka_stuck_li_timeout():
	if Up_bonus == true:
		stuck_proverka_ = true
		print("Stuck")

func _on_time_to_stop_fail_int_timeout():
	speed = 100
	jump = 180


func _on_hud_ritm_window_off():
	RITM = false
	speed = 0
	jump = 0
	$Time_to_stop_fail_int.start()
	$interaction_fail.play()
	emit_signal("fail")
func _on_hud_ritm_window_on():
	if Up_bonus == true:
		RITM = true
		emit_signal("luck")
func _on_hud_tact():
	emit_signal("tact")


func _on_hud_quality_bad():
	$quality_tap/quality_text.position = Vector2(-6,-3)
	quality_pos_x = randi_range(0,1)
	quality_pos_r = randi_range(0,2)
	quality_count = 3
	$quality_tap/time_to_quefree_quality.start()
func _on_hud_quality_good():
	$quality_tap/quality_text.position = Vector2(-6,-3)
	quality_pos_x = randi_range(0,1)
	quality_pos_r = randi_range(0,2)
	quality_count = 2
	$quality_tap/time_to_quefree_quality.start()
func _on_hud_quality_perfect():
	$quality_tap/quality_text.position = Vector2(-6,-3)
	quality_pos_x = randi_range(0,1)
	quality_pos_r = randi_range(0,2)
	quality_count = 1
	$quality_tap/time_to_quefree_quality.start()
func _on_hud_quality_fail():
	$quality_tap/quality_text.position = Vector2(-6,-3)
	quality_pos_x = randi_range(0,1)
	quality_pos_r = randi_range(0,2)
	quality_count = 4
	$quality_tap/time_to_quefree_quality.start()
func _on_time_to_quefree_quality_timeout():
	quality_text_active = true
	quality_count = 0


func _on_new_checkpoint_body_in_zone():
	if checkpoint_number == 0:
		can_make_checkpoint = true
func _on_new_checkpoint_body_not_is_zone():
	can_make_checkpoint = false
func _on_food_for_heart_proverka_hp():
	heal()
func _on_food_for_heart_2_proverka_hp():
	heal()
func _on_food_for_heart_3_proverka_hp():
	heal()


func _on_platform_toggle_player_int():
	emit_signal("new_checkpoint")
