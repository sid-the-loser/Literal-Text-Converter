extends Control

@export_category("Text Editor Options")

@export var TextEditObject: TextEdit = null

@export_category("Option Buttons")

@export var TabDetect: CheckButton = null
@export var BackspaceDetect: CheckButton = null
@export var NewLineDetect: CheckButton = null
@export var CarriageDetect: CheckButton = null
@export var FormFeedDetect: CheckButton = null
@export var SingleQuoteDetect: CheckButton = null
@export var DoubleQuoteDetect: CheckButton = null
@export var BackslashDetect: CheckButton = null

@export_category("FileDialogues")

@export var OpenFileDialogue: FileDialog = null

var appendMode: bool = false

func _on_literal_button_button_down():
	DisplayServer.clipboard_set(LiteralExtractor(TextEditObject.text))


func _on_clear_button_button_up():
	TextEditObject.set_text("")


func _on_copy_button_button_down():
	DisplayServer.clipboard_set(TextEditObject.get_text())


func _on_open_file_button_button_up():
	appendMode = false
	OpenFileDialogue.show()


func _on_append_file_button_button_up():
	appendMode = true
	OpenFileDialogue.show()


func _on_open_file_dialogue_file_selected(path):
	if path != null:
		var file = FileAccess.open(path, FileAccess.READ)
		if appendMode:
			TextEditObject.text += file.get_as_text()
		else:
			TextEditObject.text = file.get_as_text()
	

func LiteralExtractor(text: String) -> String:
	var converted = ""
	for i in range(len(text)):
		if text[i] == "\n" and NewLineDetect.button_pressed:
			converted += "\\n"
		elif text[i] == "\t" and TabDetect.button_pressed:
			converted += "\\t"
		elif text[i] == "\r" and CarriageDetect.button_pressed:
			converted += "\\r"
		elif text[i] == "\f" and FormFeedDetect.button_pressed:
			converted += "\\f"
		elif text[i] == "\\" and BackslashDetect.button_pressed:
			converted += "\\\\"
		elif text[i] == "\b" and BackspaceDetect.button_pressed:
			converted += "\\b"
		elif text[i] == '"' and DoubleQuoteDetect.button_pressed:
			converted += '\\"'
		elif text[i] == "'" and SingleQuoteDetect.button_pressed:
			converted += "\\'"
		else:
			converted += text[i]
		
	return converted
