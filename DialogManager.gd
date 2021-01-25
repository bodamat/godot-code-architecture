extends Control

export(NodePath) onready var _dialog_text = get_node(_dialog_text) as Label
export(NodePath) onready var _avatar = get_node(_avatar) as TextureRect
export(Resource) var _current_dialogue = _current_dialogue as Dialogue

var _current_slide_index := 0

func _ready():
	_avatar.texture = _current_dialogue.avatar_texture
	show_slide()
	
	GameEvents.connect("dialog_initiated", self, "_on_dialog_initiated")

func _input(event):
	if Input.is_action_just_pressed("advance_slide"):
		if _current_slide_index < _current_dialogue.dialog_slides.size() - 1:
			_current_slide_index += 1
			show_slide()
		else:
			self.visible = false

func show_slide() -> void:
	_dialog_text.text = _current_dialogue.dialog_slides[_current_slide_index]

func _on_dialog_initiated(dialogue: Dialogue) -> void:
#	print("Dialog has been initiated")
	_current_dialogue = dialogue
	_current_slide_index = 0
	_avatar.texture = dialogue.avatar_texture
	show_slide()
	self.visible = true
