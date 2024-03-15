extends Node2D
signal n_p
signal push_n_p
var number_push
var active = false
var can_int = true
var pressed = false
@export var number_platform:int
func _ready():
	$Sprite2D/AnimationPlayer.play("RESET")
	set_process(false)
	number_push = 0
	can_int = true
func _process(delta):
	if Input.is_action_just_pressed("interaction") and can_int:
		if not pressed:
			pressed = true
			$Sprite2D/AnimationPlayer.play("toggle_on")
		else:
			$Sprite2D/AnimationPlayer.play("toggle_off")
			pressed = false
		while number_push < number_platform:
			number_push += 1
			emit_signal("n_p")
			print(number_push)
		if number_push > (number_platform -1):
			can_int = false
			emit_signal("push_n_p")
			number_push = 0
			$Timer.start()
func _on_area_2d_body_entered(body:PhysicsBody2D):
	set_process(true)
func _on_area_2d_body_exited(body:PhysicsBody2D):
	set_process(false)

func _on_timer_timeout():
	can_int = true
