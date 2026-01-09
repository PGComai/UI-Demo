@tool
extends Control
class_name Dial


@export var ticks: int = 50:
	set(value):
		if ticks != value:
			ticks = value
			place_ticks()
@export var tick_texture: Texture2D


@onready var texture_rect: TextureRect = $TextureRect


func get_radius() -> float:
	return minf(size.x, size.y) / 2.0


func get_center() -> Vector2:
	return Vector2(size.x / 2.0, size.y / 2.0)


func place_ticks() -> void:
	for child in texture_rect.get_children():
		child.queue_free()
	var rad: float = get_radius()
	var center: Vector2 = get_center()
	
	for t in ticks:
		var new_tex := TextureRect.new()
		new_tex.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		new_tex.texture = tick_texture
		texture_rect.add_child(new_tex)
		
		var angle: float = (float(t) / float(ticks)) * TAU
		new_tex.position.x = center.x + (cos(angle) * rad * 0.9)
		new_tex.position.y = center.y + (sin(angle) * rad * 0.9)
		
		new_tex.position -= (new_tex.size / 2.0)
