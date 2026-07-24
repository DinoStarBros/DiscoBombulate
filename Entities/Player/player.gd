extends EntityClass
class_name Player

var desire_scale : Vector2 = Vector2(1.5,1.5)

func _init() -> void:
	EventBus.MusicBeatTick.connect(beat_tick)

func beat_tick() -> void:
	scale.x += 0.4
	%thif.play()

func _physics_process(delta: float) -> void:
	scale.y = scale.x
	scale = lerp(scale, desire_scale, 20.0 * delta)
