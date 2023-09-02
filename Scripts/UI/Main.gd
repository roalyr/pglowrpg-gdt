extends Control

func _ready():
	Paths.window_splash.show()
	Paths.window_menu.hide()
	Paths.window_worldgen.hide()
	
	# Get the viewport size signal.
	get_tree().get_root().size_changed.connect(is_viewport_size_changed)
	# Make the first call.
	is_viewport_size_changed()
	
	# Connect other signals.
	Signals.ui_scale_changed.connect(is_ui_scale_changed)
	
func is_viewport_size_changed():
	if size.x < size.y:
		Signals.viewport_portrait.emit(true)
	else:
		Signals.viewport_portrait.emit(false)

func is_ui_scale_changed():
	print(GameState.ui_scale)
