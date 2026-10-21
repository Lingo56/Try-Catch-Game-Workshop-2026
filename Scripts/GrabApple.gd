extends Area2D

@onready var sprite: AnimatedSprite2D = $SparkleSprite
@onready var parent_sprite: CanvasItem = get_parent()

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		set_deferred("monitoring", false)
		sprite.visible = true
		sprite.play("default")

		get_tree().call_group("win_screen", "show_win")  # trigger the win UI

		var tween := create_tween()
		tween.tween_property(parent_sprite, "modulate:a", 0.0, 1.0)
		await tween.finished
		parent_sprite.queue_free()
