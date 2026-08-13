extends Node
class_name Arena

func _init() -> void:
	MusicManager.play_song("combat2")
	EventBus.StartBeat.emit()
