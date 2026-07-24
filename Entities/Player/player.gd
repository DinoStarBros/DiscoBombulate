extends EntityClass
class_name Player

@onready var sprite: Sprite2D = %sprite

var sprite_desire_scale : Vector2 = Vector2(2,2)
var desire_move : Vector2

func _init() -> void:
	EventBus.MusicBeatTick.connect(beat_tick)

func beat_tick() -> void:
	sprite.scale.x += 0.4
	%thif.play()
	
	global_position += desire_move * 32

func _physics_process(delta: float) -> void:
	sprite.scale.y = sprite.scale.x
	sprite.scale = lerp(sprite.scale, sprite_desire_scale, 20.0 * delta)

func _input(event: InputEvent) -> void:
	desire_move = Input.get_vector("left", "right", "up", "down")
