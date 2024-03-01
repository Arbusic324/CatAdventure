extends CharacterBody2D
var touched = false
signal proverka_hp
var move = [175,50]
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var food_random = [randi_range(0,1),randi_range(0,1)]
var can_eat = false
var in_zone = false
func _ready():
	set_physics_process(false)
	$food_1.visible = false
	$food_2.visible = false
	if food_random[0] == 0:
		$food_1.visible = true
	elif food_random[0] == 1:
		$food_2.visible = true
func _physics_process(delta):
	var uv
	if food_random[1] > 0:
		uv = 1
	else:
		uv = -1
	velocity.x = move[1] * uv
	velocity.y += (gravity * delta)*.7
	move_and_slide()
func _on_node_2d_body_entered(body: PhysicsBody2D):
	if touched == false:
		in_zone = true
		emit_signal("proverka_hp")
func _on_timer_timeout():
	$food_1.visible = false
	$food_2.visible = false
	set_physics_process(false)

func _on_node_2d_body_exited(body: PhysicsBody2D):
	in_zone = false
func _on_player_cat_eated():
	if in_zone:
		set_physics_process(true)
		velocity.y = -move[0]
		$Timer.start()
		touched = true
