extends Node

@onready var main : Control = get_tree().get_root().get_node("Main")
@onready var window_splash : Control = main.get_node("Window_splash")
@onready var window_menu : Control = main.get_node("Window_menu")
@onready var window_worldgen : Control = main.get_node("Window_worldgen")
@onready var window_worldgen_text : Label = window_worldgen.get_node("Text_frame/Scroll_container/Text_output")
@onready var worldgen : Node = window_worldgen.get_node("Worldgen")
