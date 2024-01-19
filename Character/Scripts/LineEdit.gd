extends LineEdit

var MouseOver = false

func _input(event):
	if event is InputEventMouseButton and not MouseOver:
		release_focus()
	if event.is_action_pressed("ui_accept"):
		grab_focus()



func _on_mouse_exited():
	MouseOver = false
	pass # Replace with function body.

func _on_mouse_entered():
	MouseOver = true
	pass # Replace with function body.

func _on_text_submitted(new_text):
	if has_focus():
		release_focus()
	await get_tree().create_timer(0.1).timeout
	clear()
