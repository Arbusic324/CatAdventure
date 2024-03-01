extends Node2D
signal ritm_window_on
signal ritm_window_off
signal tact
var active = false
var ritm_started = false
var interaction = false
var ritm_okno = false
func _ready():
	active = false
	$part_1/AnimationPlayer.play("reality_Off")
	$part_2/AnimationPlayer.play("reality_Off")
func _process(delta):
	if active:
		if interaction and ritm_okno:
			interaction = false
			emit_signal("ritm_window_on")
		elif interaction == true and ritm_okno == false:
			interaction = false
			$Replay.start()
			$part_1/AnimationPlayer.play("reality_on")
			$part_2/AnimationPlayer.play("reality_on")
			emit_signal("ritm_window_off")
	if active == false:
		$part_1/AnimationPlayer.play("reality_Off")
		$part_2/AnimationPlayer.play("reality_Off")
func _on_player_cat_ritm_on():
	active = true
	$Time_window_anim.start()
	$Timer.start()
	$part_1/AnimationPlayer.play("active")
	$part_2/AnimationPlayer.play("active")
func _on_player_cat_ritm_off():
	active = false
	ritm_okno = false
	
func _on_player_cat_interaction():
	interaction = true
func _on_timer_timeout():
	if active:
		emit_signal("tact")
		$AudioStreamPlayer.play()
		$Time_vzaimodeystvia.start()
		$part_1/AnimationPlayer.play("reality_on")
		$part_2/AnimationPlayer.play("reality_on")

func _on_time_vzaimodeystvia_timeout():
	if active == true and ritm_okno == true:
		ritm_okno = false
		$Timer.start()
		$Time_window_anim.start()
		$part_1/AnimationPlayer.play("active")
		$part_2/AnimationPlayer.play("active")
	


func _on_replay_timeout():
	if active:
		ritm_okno = false
		$Time_window_anim.start()
		$Timer.start()
		$part_1/AnimationPlayer.play("active")
		$part_2/AnimationPlayer.play("active")
		
func _on_time_window_anim_timeout():
	if active:
		ritm_okno = true
