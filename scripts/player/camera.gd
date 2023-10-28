extends Camera2D

var player : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../Player"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = player.position
