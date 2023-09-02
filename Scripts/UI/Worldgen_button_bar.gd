extends Control
	
	
func _on_button_back_pressed():
	Paths.window_worldgen.hide()
	Paths.window_menu.show()


func _on_button_start_pressed():
	self.get_node("Button_start").disabled = true
	await get_tree().create_timer(0.5).timeout
	Paths.worldgen.start()
	await get_tree().create_timer(0.5).timeout
	self.get_node("Button_start").disabled = false


func _on_button_preset_item_selected(index):
	Paths.worldgen.map_size = int(Paths.window_worldgen_button_preset.get_item_text(index))
