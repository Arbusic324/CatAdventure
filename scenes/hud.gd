extends Control
var count = 0
var HP = 3
var MAX_HP
var died = false
signal ritm_window_on
signal ritm_window_off
signal tact 

signal quality_perfect
signal quality_good
signal quality_bad
signal quality_fail

var active = false
var ritm_started = false
var interaction = false
var ritm_okno = false
var quality_tap = 0
func _ready():
	$CanvasLayer/main/heart1/AnimationPlayer.play("reality_on")
	$CanvasLayer/main/heart2/AnimationPlayer.play("reality_on")
	$CanvasLayer/main/heart3/AnimationPlayer.play("reality_on")
	active = false
	$CanvasLayer/main/ritm_bar/ritm_anim.play("noActive")
	count = 0
	$CanvasLayer/Label.text = "Strike: 0"
	$CanvasLayer/Label.modulate = Color(0.686, 0.353, 0.89)
func _on_player_cat_fail():
	$CanvasLayer/Label.modulate = Color(0.319, 0.595, 0.534)
	count = 0
	$CanvasLayer/Label.text = "Strike: 0"
func _on_player_cat_luck():
	$CanvasLayer/Label.modulate = Color(0.686, 0.353, 0.89)
	if count < 20:
		count += 1
	if count == 1:
		$CanvasLayer/Label.text = "Strike: 1"
	if count == 2:
		$CanvasLayer/Label.text = "Strike: 2"
	if count == 3:
		$CanvasLayer/Label.text = "Strike: 3"
	if count == 4:
		$CanvasLayer/Label.text = "Strike: 4"
	if count == 5:
		$CanvasLayer/Label.text = "Strike: 5"
	if count == 6:
		$CanvasLayer/Label.text = "Strike: 6"
	if count == 7:
		$CanvasLayer/Label.text = "Strike: 7"
	if count == 8:
		$CanvasLayer/Label.text = "Strike: 8"
	if count == 9:
		$CanvasLayer/Label.text = "Strike: 9"
	if count == 10:
		$CanvasLayer/Label.text = "Strike: 10"
	if count == 11:
		$CanvasLayer/Label.text = "Strike: 11"
	if count == 12:
		$CanvasLayer/Label.text = "Strike: 12"
	if count == 13:
		$CanvasLayer/Label.text = "Strike: 13"
	if count == 14:
		$CanvasLayer/Label.text = "Strike: 14"
	if count == 15:
		$CanvasLayer/Label.text = "Strike: 15"
	if count == 16:
		$CanvasLayer/Label.text = "Strike: 16"
	if count == 17:
		$CanvasLayer/Label.text = "Strike: 17"
	if count == 18:
		$CanvasLayer/Label.text = "Strike: 18"
	if count == 19:
		$CanvasLayer/Label.text = "Strike: 19"
	if count == 20:
		$CanvasLayer/Label.text = "Strike: Max"
func _on_player_cat_camera_ded():
	$CanvasLayer/Label.text = "Strike: 0"
	$CanvasLayer/Label.modulate = Color(0.319, 0.595, 0.534)
	count = 0
	
func _process(delta):
	if HP == 3:
		MAX_HP = true
	else:
		MAX_HP = false
	if active:
		if interaction and ritm_okno:
			interaction = false
			emit_signal("ritm_window_on")
			if quality_tap == 1:
				emit_signal("quality_perfect")
			elif quality_tap == 2:
				emit_signal("quality_good")
			elif quality_tap == 3:
				emit_signal("quality_bad")
		elif interaction == true and ritm_okno == false:
			interaction = false
			$CanvasLayer/main/ritm_bar/Replay.start()
			$CanvasLayer/main/ritm_bar/ritm_anim.play("noActive")
			emit_signal("ritm_window_off")
			emit_signal("quality_fail")
	if active == false:
		$CanvasLayer/main/ritm_bar/ritm_anim.play("noActive")
func _on_player_cat_ritm_on():
	active = true
	$CanvasLayer/main/ritm_bar/Time_window_anim.start()
	$CanvasLayer/main/ritm_bar/Timer.start()
	$CanvasLayer/main/ritm_bar/ritm_anim.play("ACtive")
func _on_player_cat_ritm_off():
	active = false
	ritm_okno = false
	
func _on_player_cat_interaction():
	interaction = true
func _on_timer_timeout():
	if active:
		emit_signal("tact")
		$CanvasLayer/main/ritm_bar/AudioStreamPlayer.play()
		$CanvasLayer/main/ritm_bar/Time_vzaimodeystvia.start()
		$CanvasLayer/main/ritm_bar/ritm_anim.play("noActive")
func _on_time_vzaimodeystvia_timeout():
	if active == true and ritm_okno == true:
		ritm_okno = false
		$CanvasLayer/main/ritm_bar/Timer.start()
		$CanvasLayer/main/ritm_bar/Time_window_anim.start()
		$CanvasLayer/main/ritm_bar/ritm_anim.play("ACtive")
func _on_replay_timeout():
	if active:
		ritm_okno = false
		$CanvasLayer/main/ritm_bar/Time_window_anim.start()
		$CanvasLayer/main/ritm_bar/Timer.start()
		$CanvasLayer/main/ritm_bar/ritm_anim.play("ACtive")
		
func _on_time_window_anim_timeout():
	if active:
		quality_tap = 1
		$CanvasLayer/main/ritm_bar/Window_perfect_time/perfect_time.start()
		$CanvasLayer/main/ritm_bar/Window_perfect_time/good_time.start()
		$CanvasLayer/main/ritm_bar/Window_perfect_time/bad_time.start()
		ritm_okno = true
##################################################################
func _on_player_cat_take_damage():
	HP = HP - 1
	if HP == 2:
		$CanvasLayer/main/heart3/AnimationPlayer.play("damage_take")
	if HP == 1:
		$CanvasLayer/main/heart2/AnimationPlayer.play("damage_take")
	if HP == 0:
		$CanvasLayer/main/heart1/AnimationPlayer.play("damage_take")
		died = true

func _on_player_cat_heart_bonus():
	if HP == 3:
		pass
	else:
		if HP == 2:
			$CanvasLayer/main/heart3/AnimationPlayer.play("regeneraion")
			HP += 1
		elif HP == 1:
			$CanvasLayer/main/heart2/AnimationPlayer.play("regeneraion")
			HP += 1
func _on_player_cat_int_heart():
	if died == true:
		HP = 3
		$CanvasLayer/main/heart1/AnimationPlayer.play("regeneraion")
		$CanvasLayer/main/heart1/Time_redeem_heart_1.start()
		
########### ПЛАВНЫЕ СЕРДЦА
func _on_time_redeem_heart_1_timeout():
	$CanvasLayer/main/heart2/AnimationPlayer.play("regeneraion")
	$CanvasLayer/main/heart2/Time_redeem_heart_2.start()
func _on_time_redeem_heart_2_timeout():
		$CanvasLayer/main/heart3/AnimationPlayer.play("regeneraion")

######################## PERFECT GOOD BAD
func _on_good_time_timeout():
	quality_tap = 3
func _on_perfect_time_timeout():
	quality_tap = 2
func _on_bad_time_timeout():
	pass
	#quality_tap = 4
