extends Control

export(NodePath) onready var _dialog_text = get_node(_dialog_text) as Label
export(NodePath) onready var _avatar = get_node(_avatar) as TextureRect
export(Resource) var _current_dialogue = _current_dialogue as Dialogue

export(Resource) var _runtime_data = _runtime_data as RuntimeData

var _current_slide_index := 0

func _ready():
	_avatar.texture = _current_dialogue.avatar_texture
	show_slide()
	
	GameEvents.connect("dialog_initiated", self, "_on_dialog_initiated")
	GameEvents.connect("dialog_finished", self, "_on_dialog_finished")

func _input(_event):
	if Input.is_action_just_pressed("advance_slide"):
		if _current_slide_index < _current_dialogue.dialog_slides.size() - 1:
			_current_slide_index += 1
			show_slide()
		elif _runtime_data.current_gameplay_state == Enums.GameplayState.IN_DIALOG:
			GameEvents.emit_dialog_finished()


func show_slide() -> void:
	_dialog_text.text = _current_dialogue.dialog_slides[_current_slide_index]

func _on_dialog_initiated(dialogue: Dialogue) -> void:
	_runtime_data.current_gameplay_state = Enums.GameplayState.IN_DIALOG
	_current_dialogue = dialogue
	_current_slide_index = 0
	_avatar.texture = dialogue.avatar_texture
	show_slide()
	self.visible = true

func _on_dialog_finished() -> void:
	_runtime_data.current_gameplay_state = Enums.GameplayState.FREEWALK
	self.visible = false
