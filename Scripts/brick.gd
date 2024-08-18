extends MeshInstance3D
class_name Brick


@export var size:Vector3i
@export var offset:Vector2i
var pos:Vector3i = Vector3i.ZERO
var rot:int = 0


static func checkSpace(pos:Vector3i, rot:int, size:Vector3i, offset:Vector2i) -> bool:
	match rot:
		0:
			for x in range(0, size.x):
				for y in range(0, size.y):
					for z in range(0, size.z):
						if BuildPlate.getpos(Vector3i(x, y, z) + Vector3i(offset.x, 0, offset.y) + pos):
							return false
		1:
			for x in range(0, size.x):
				for y in range(0, size.y):
					for z in range(0, -size.z, -1):
						if BuildPlate.getpos(Vector3i(x, y, z) + Vector3i(offset.x, 0, -offset.y) + pos):
							return false
		2:
			for x in range(0, -size.x, -1):
				for y in range(0, size.y):
					for z in range(0, -size.z, -1):
						if BuildPlate.getpos(Vector3i(x, y, z) + Vector3i(-offset.x, 0, -offset.y) + pos):
							return false
		3:
			for x in range(0, -size.x, -1):
				for y in range(0, size.y):
					for z in range(0, size.z):
						if BuildPlate.getpos(Vector3i(x, y, z) + Vector3i(-offset.x, 0, offset.y) + pos):
							return false
	return true


func fill(f:bool) -> void:
	match rot:
		0:
			for x in range(0, size.x):
				for y in range(0, size.y):
					for z in range(0, size.z):
						BuildPlate.setpos(Vector3i(x, y, z) + Vector3i(offset.x, 0, offset.y) + pos, f)
		1:
			for x in range(0, size.x):
				for y in range(0, size.y):
					for z in range(0, -size.z, -1):
						BuildPlate.setpos(Vector3i(x, y, z) + Vector3i(offset.x, 0, -offset.y) + pos, f)
		2:
			for x in range(0, -size.x, -1):
				for y in range(0, size.y):
					for z in range(0, -size.z, -1):
						BuildPlate.setpos(Vector3i(x, y, z) + Vector3i(-offset.x, 0, -offset.y) + pos, f)
		3:
			for x in range(0, -size.x, -1):
				for y in range(0, size.y):
					for z in range(0, size.z):
						BuildPlate.setpos(Vector3i(x, y, z) + Vector3i(-offset.x, 0, offset.y) + pos, f)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_degrees.y = -90 + (90 * rot)
	position = BuildPlate.unConvert(pos)
	fill(true)


func _on_static_body_3d_input_event(camera: Node, event: InputEvent, pos: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("game_break"):
		fill(false)
		queue_free()
	else:
		BuildPlate.instance.click_event(camera, event, pos, normal, shape_idx)
