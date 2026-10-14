extends CharacterBody2D

@export var speed := 100.0
@onready var _animation_player = $AnimatedSprite2D

func _physics_process(_delta):
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	if direction == Vector2.ZERO:
		_animation_player.stop()
	elif abs(direction.x) > abs(direction.y):
		_animation_player.play("walk_right" if direction.x > 0 else "walk_left")
	else:
		_animation_player.play("walk_down" if direction.y > 0 else "walk_up")
