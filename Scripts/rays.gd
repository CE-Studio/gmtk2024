extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in 25:
		for y in 50:
			var h = RayCast3D.new()
			add_child(h)
			h.target_position = Vector3.FORWARD * 101
			h.position = Vector3(((100 / 25.0) * x) - 50, ((240 / 50) * y), 50)
			h.name = str(x) + "x" + str(y)
			h.process_mode = Node.PROCESS_MODE_DISABLED
