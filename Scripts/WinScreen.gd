extends CanvasLayer

@onready var root_ui: Control = $Control

func _ready() -> void:
	add_to_group("win_screen")
	root_ui.modulate.a = 0.0       # start invisible
	root_ui.pivot_offset = root_ui.size / 2.0  # scale from the center

func show_win() -> void:
	root_ui.pivot_offset = root_ui.size / 2.0
	root_ui.scale = Vector2(0.5, 0.5)
	root_ui.modulate.a = 0.0

	var tween := create_tween()

	# Fade in + bounce in at the same time
	tween.set_parallel(true)
	tween.tween_property(root_ui, "modulate:a", 1.0, 0.4)
	tween.tween_property(root_ui, "scale", Vector2.ONE, 0.6)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	# Hold, then fade out (chained after the parallel part finishes)
	tween.set_parallel(false)
	tween.tween_interval(2.0)
	tween.tween_property(root_ui, "modulate:a", 0.0, 0.5)
