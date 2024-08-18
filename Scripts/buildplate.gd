extends Node3D
class_name BuildPlate


static var _area:Array = []
static var instance:BuildPlate

static var parts:Array[Brick] = [
	preload("res://bricks/scn/2x2.tscn").instantiate()
]


var _rotspeed:float = 0
@onready var hlight:MeshInstance3D = $highlight
var htargpos:Vector3 = Vector3.ZERO
var brickID:int
var toolrot:int = 0


@export var okColor:Color
@export var badColor:Color


static func getpos(pos:Vector3i) -> bool:
	if (pos.x > 24) or (pos.x < 0):
		return true
	if (pos.y > 49) or (pos.y < 0):
		return true
	if (pos.z > 24) or (pos.z < 0):
		return true
	return _area[pos.x][pos.y][pos.z]


static func setpos(pos:Vector3i, f:bool) -> void:
	if (pos.x > 24) or (pos.x < 0):
		return
	if (pos.y > 49) or (pos.y < 0):
		return
	if (pos.z > 24) or (pos.z < 0):
		return
	_area[pos.x][pos.y][pos.z] = f


static func posConvert(pos:Vector3) -> Vector3i:
	var x := floori(remap(pos.x, -1, 1, 0, 25))
	var y := floori(remap(pos.y, 0, 4.8, 0, 50))
	var z := floori(remap(pos.z, -1, 1, 0, 25))
	return Vector3i(x, y, z)


static func unConvert(pos:Vector3i) -> Vector3:
	var x := remap(pos.x, 0, 25, -1, 1)
	var y := remap(pos.y, 0, 50, 0, 4.8)
	var z := remap(pos.z, 0, 25, -1, 1)
	return Vector3(x, y, z) + Vector3(0.04, 0, 0.04)


func _ready() -> void:
	instance = self
	for x in 25:
		_area.append([])
		for y in 50:
			_area[-1].append([])
			for z in 25:
				_area[-1][-1].append(false)
	setBrick(0)


func setBrick(id:int) -> void:
	hlight.mesh = parts[id].mesh
	brickID = id


func selbrick() -> Brick:
	return parts[brickID]


func _process(_delta: float) -> void:
	_rotspeed = lerpf(_rotspeed, Input.get_axis("game_rotate_ccw", "game_rotate_cw"), clampf(_delta * 6, 0, 1))
	rotate_y(_rotspeed * _delta)
	hlight.position = hlight.position.lerp(htargpos, clampf(_delta * 20, 0, 1))
	hlight.rotation_degrees.y = -90 + (toolrot * 90)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_brick_ccw"):
		toolrot += 1
		if toolrot >= 4:
			toolrot = 0
	elif event.is_action_pressed("game_brick_cw"):
		toolrot -= 1
		if toolrot < 0:
			toolrot = 3


func click_event(_camera: Node, event: InputEvent, pos: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		var a = posConvert(to_local(pos + Vector3(0, 0.001, 0)))
		htargpos = unConvert(a)
		var b := selbrick()
		if Brick.checkSpace(a, toolrot, b.size, b.offset):
			hlight.material_override.albedo_color = okColor
		else:
			hlight.material_override.albedo_color = badColor
	if event.is_action_pressed("game_place"):
		var a = posConvert(to_local(pos + Vector3(0, 0.001, 0)))
		var b := selbrick()
		if Brick.checkSpace(a, toolrot, b.size, b.offset):
			hlight.material_override.albedo_color = okColor
			var nb := b.duplicate()
			nb.pos = a
			nb.rot = toolrot
			add_child(nb)
		else:
			hlight.material_override.albedo_color = badColor
