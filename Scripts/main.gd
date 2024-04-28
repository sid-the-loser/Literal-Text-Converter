extends Control

@export var TextEditObject: TextEdit = null


func _on_literal_button_button_down():
	DisplayServer.clipboard_set(LiteralExtractor(TextEditObject.text))


func _on_clear_button_button_up():
	TextEditObject.set_text("")


func _on_copy_button_button_down():
	DisplayServer.clipboard_set(TextEditObject.get_text())


func LiteralExtractor(text: String) -> String:
	var converted = ""
	for i in range(len(text)):
		if text[i] == "\n":
			converted += "\\n"
		elif text == "\t":
			converted += "\\t"
		else:
			converted += text[i]
	return converted
