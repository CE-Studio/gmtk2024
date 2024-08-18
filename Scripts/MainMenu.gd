extends Control


const fade_amount:float = 15.0
var credits_open:bool = false


@onready var credits:TextureRect = $"CreditsParent"


func _ready():
	pass # Replace with function body.


func _process(delta):
	if InputEventMouseButton and credits_open:
		credits_open = false
	if credits_open:
		credits.modulate.a = lerp(0.0, 1.0, credits.modulate.a + (delta * fade_amount))
	else:
		credits.modulate.a = lerp(0.0, 1.0, credits.modulate.a - (delta * fade_amount))


func on_play_button():
	print("Play!")
	if !credits_open:
		pass


func on_credits_button():
	print("Credits!")
	credits_open = true

