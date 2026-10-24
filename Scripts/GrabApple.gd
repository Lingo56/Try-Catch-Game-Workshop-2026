extends Area2D

@onready var sprite: AnimatedSprite2D = $SparkleSprite
@onready var parent_sprite: CanvasItem = get_parent()
@onready var tilemap_layer: TileMapLayer = $"../TileMapLayer"  # adjust path to your scene

var triggered := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if triggered or not body.is_in_group("player"):
		return
	triggered = true

	set_deferred("monitoring", false)
	sprite.modulate.a = 1.0
	sprite.visible = true
	sprite.play("default")

	get_tree().call_group("win_screen", "show_win")

	parent_sprite.self_modulate.a = 0.0

	var tween := create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(parent_sprite, "self_modulate:a", 1.0, 1.0)  # fade in
	tween.tween_interval(1.0)                                          # hold
	tween.tween_property(parent_sprite, "self_modulate:a", 0.0, 1.0)  # fade out
	tween.parallel().tween_property(sprite, "modulate:a", 0.0, 1.0)   # sparkle fades out
	tween.parallel().tween_property(tilemap_layer, "modulate:a", 0.0, 1.0)  # apple fades out
	await tween.finished

	await get_tree().create_timer(5.0, false).timeout

	tilemap_layer.queue_free()
	parent_sprite.queue_free()
