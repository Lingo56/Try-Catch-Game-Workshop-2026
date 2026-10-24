extends Area2D

@onready var sprite: AnimatedSprite2D = $SparkleSprite
@onready var parent_sprite: CanvasItem = get_parent()

var triggered := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if triggered or not body.is_in_group("player"):
		return
	triggered = true

	set_deferred("monitoring", false)
	sprite.visible = true
	sprite.play("default")

	get_tree().call_group("win_screen", "show_win")

	parent_sprite.self_modulate.a = 0.0  # start fully transparent

	var tween := create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(parent_sprite, "self_modulate:a", 1.0, 1.0)  # fade in
	tween.tween_interval(1.0)                                          # hold
	tween.tween_property(parent_sprite, "self_modulate:a", 0.0, 1.0)  # fade out
	await tween.finished

	parent_sprite.queue_free()
