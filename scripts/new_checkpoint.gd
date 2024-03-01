extends Node2D
signal body_in_zone
signal body_not_is_zone
var uv = false
var can_int = true
func _ready():
	$Area2D/Sprite2D/AnimationPlayer.play("idle")
func _on_area_2d_body_entered(body: PhysicsBody2D):
	emit_signal("body_in_zone")

func _on_area_2d_body_exited(body: PhysicsBody2D):
	emit_signal("body_not_is_zone")


func _on_player_cat_int_botl_1():
	if can_int:
		can_int = false
		if uv:
			$Area2D/Sprite2D.flip_h = true
		else:
			$Area2D/Sprite2D.flip_h = false
		$Area2D/Sprite2D/AnimationPlayer.play("int")
func _on_player_cat_flip_h():
		uv = false
func _on_player_cat_flip_h__():
		uv = true
