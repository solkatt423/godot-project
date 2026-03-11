extends CharacterBody2D


@export var move_speed : float = 50
@export var animator : AnimatedSprite2D

var is_game_over : bool = false

@export var bullet_scene : PackedScene
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_game_over:
		velocity = Input.get_vector("left","right","up","down")* move_speed
		#如果速度为0，播放待机动画
		if velocity== Vector2.ZERO:
			animator.play("idle")
		#如果速度不为0，播放跑步动画
		else:
			animator.play("run")
			
		move_and_slide()

func game_over():
	is_game_over = true
	animator.play("game_over")
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()


func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(6,6)
	get_tree().current_scene.add_child(bullet_node)
