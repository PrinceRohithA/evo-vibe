extends CanvasLayer


func _on_left_pressed():
	Global.mobile_left = true

func _on_left_released():
	Global.mobile_left = false

func _on_right_pressed():
	Global.mobile_right = true

func _on_right_released():
	Global.mobile_right = false

func _on_jump_pressed():
	Global.mobile_jump = true

func _on_jump_released():
	Global.mobile_jump = false
