extends Label

# Array of names
var names = ["Juan", "María", "Carlos", "Ana"]

func _ready():
	update_names()

# Function to update the text with the names
func update_names():
	text = "Nombres:\n" + "\n".join(names)
