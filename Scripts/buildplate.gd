extends Node3D
class_name BuildPlate


static var _area:Array = []


static func getpos(pos:Vector3i) -> bool:
	if (pos.x > 24) or (pos.x < 0):
		return true
	if (pos.y > 49) or (pos.x < 0):
		return true
	if (pos.z > 24) or (pos.x < 0):
		return true
	return _area[pos.x][pos.y][pos.z]


static func posConvert(pos:Vector3) -> Vector3i:
	var x := floori(remap(pos.x, -1, 1, 0, 25))
	var y := floori(remap(pos.y, 0, 1, 0, 25))
	var z := floori(remap(pos.z, -1, 1, 0, 25))
	return Vector3i(x, y, z)


static func unConvert(pos:Vector3i) -> Vector3:
	var x := remap(pos.x, 0, 25, -1, 1)
	var y := remap(pos.y, 0, 25, 0, 1)
	var z := remap(pos.z, 0, 25, -1, 1)
	return Vector3(x, y, z)

func _ready() -> void:
	for x in 25:
		_area.append([])
		for y in 50:
			_area[-1].append([])
			for z in 25:
				_area[-1][-1].append(false)


func _process(_delta: float) -> void:
	rotate_y(Input.get_axis("game_rotate_ccw", "game_rotate_cw") * _delta)


func click_event(_camera: Node, event: InputEvent, pos: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("game_place"):
		var a = posConvert(to_local(pos + Vector3(0, 0.001, 0)))
		print(a)
		$MeshInstance3D2.position = unConvert(a)
