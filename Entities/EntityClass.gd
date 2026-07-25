extends CharacterBody2D
class_name EntityClass

var tile_position : Vector2

func position_by_tile_smooth(delta: float) -> void:
	global_position = lerp(
		global_position,
		tile_position * Global.TILE_SIZE,
		12.0 * delta
		)
