extends Node3D
class_name BuildPlate


static var _area:Array = []


func _ready() -> void:
	for x in 25:
		_area.append([])
		for y in 50:
			_area[-1].append([])
			for z in 25:
				_area[-1][-1].append(false)


func _process(_delta: float) -> void:
	pass
