extends Node

@onready var main : Control = get_tree().get_root().get_node("Main")

@onready var window_splash : Control = main.get_node("Window_splash")

@onready var window_menu : Control = main.get_node("Window_menu")
@onready var window_menu_button_ui_scale : OptionButton = window_menu.get_node("Menu_button_bar/Button_ui_scale")

@onready var window_worldgen : Control = main.get_node("Window_worldgen")
@onready var window_worldgen_button_preset : OptionButton = window_worldgen.get_node("Worldgen_button_bar/Button_preset")
@onready var window_worldgen_text : Label = window_worldgen.get_node("Text_frame/Scroll_container/Text_output")
@onready var window_worldgen_image : TextureRect = window_worldgen.get_node("Image_frame/Scroll_container/Image_output")
@onready var worldgen : Node = window_worldgen.get_node("Worldgen")
