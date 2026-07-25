extends EntityClass
class_name Player

@onready var sprite: Sprite2D = %sprite
@onready var move_indicator: Sprite2D = %MoveIndicator
@onready var attack_indicator: Sprite2D = %AttackIndicator

var sprite_desire_scale : Vector2 = Vector2(2,2)
var desire_move : Vector2

func _init() -> void:
	EventBus.MusicBeatTick.connect(beat_tick)

func beat_tick() -> void:
	if sprite:
		sprite.scale.x += 0.4
	if desire_move != Vector2.ZERO:
		%step.pitch_scale = 1 + randf_range(-.2,.2)
		%step.play()
	
	tile_position += desire_move

func _physics_process(delta: float) -> void:
	sprite.scale.y = sprite.scale.x
	sprite.scale = lerp(sprite.scale, sprite_desire_scale, 20.0 * delta)
	
	position_by_tile_smooth(delta)
	
	move_indicator.look_at(desire_move + global_position)
	move_indicator.visible = desire_move != Vector2.ZERO

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("right"):
		desire_move.x = 1
	elif Input.is_action_pressed("left"):
		desire_move.x = -1
	else:
		desire_move.x = 0
	
	if Input.is_action_pressed("down"):
		desire_move.y = 1
	elif Input.is_action_pressed("up"):
		desire_move.y = -1
	else:
		desire_move.y = 0
