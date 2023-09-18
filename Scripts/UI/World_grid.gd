extends GridContainer

var grid_size = 20
var tile = Button

# Called when the node enters the scene tree for the first time.
func render():
	# Remove previous.
	for c in self.get_children():
		c.queue_free()
	
	self.columns = grid_size
	for i in range(grid_size*grid_size):
		# Create and adjust the tile-button.
		var tile_instance = tile.new()
		var tile_id = str(Paths.worldgen.array[i]/16)
		var path = 'res://Assets/Images/' + tile_id + '.png'
		tile_instance.name = str(i)
		tile_instance.icon = load(path)
		tile_instance.mouse_filter = Control.MOUSE_FILTER_PASS
		self.add_child(tile_instance)

