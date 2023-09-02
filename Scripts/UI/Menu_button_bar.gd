extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_worldgen_pressed():
	Paths.window_worldgen.show()
	Paths.window_menu.hide()


func _on_button_ui_scale_item_selected(index):
	GameState.ui_scale = float(Paths.window_menu_button_ui_scale.get_item_text(index))
	Signals.ui_scale_changed.emit()
