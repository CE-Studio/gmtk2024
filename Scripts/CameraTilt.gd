extends Camera3D


const cam_range_X:float = 60.0
const cam_range_Y:float = 40.0
const cam_smooth_rate:float = 10.0


var origin_rot:Vector3


func _ready():
	origin_rot = rotation_degrees


func _process(delta):
	var viewport_size = get_viewport().size
	var mouse_pos = get_viewport().get_mouse_position()
	var rangeX:float = inverse_lerp(0.0, viewport_size.x, mouse_pos.x)
	rangeX = abs(clampf(rangeX, 0.0, 1.0) - 1.0)
	var rangeY:float = inverse_lerp(0.0, viewport_size.y, mouse_pos.y)
	rangeY = abs(clampf(rangeY, 0.0, 1.0) - 1.0)
	var target_rot_x = lerpf(origin_rot.y - cam_range_X, origin_rot.y + cam_range_X, rangeX)
	rotation_degrees.y = lerpf(rotation_degrees.y, target_rot_x, delta * cam_smooth_rate)
	var target_rot_y = lerpf(origin_rot.x - cam_range_Y, origin_rot.x + cam_range_Y, rangeY)
	rotation_degrees.x = lerpf(rotation_degrees.x, target_rot_y, delta * cam_smooth_rate)
