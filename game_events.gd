extends Node

signal dialog_initiated(dialogue)
signal dialog_finished

signal food_moused_over
signal food_moused_out
signal food_clicked

func emit_dialog_initiated(dialogue: Dialogue) -> void:
	call_deferred("emit_signal", "dialog_initiated", dialogue)

func emit_dialog_finished() -> void:
	call_deferred("emit_signal", "dialog_finished")
