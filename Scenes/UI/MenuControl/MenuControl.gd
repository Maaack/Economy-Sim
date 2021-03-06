extends Control


signal start_button_pressed

onready var current_panel : Panel = $MenuContainer/IntroPanel

func _swipe_in(next_panel : Panel):
	$AnimationPlayer.play("SwipeOutLeft")
	yield($AnimationPlayer,"animation_finished")
	current_panel.visible = false
	next_panel.visible = true
	$AnimationPlayer.play("SwipeInRight")
	yield($AnimationPlayer, "animation_finished")
	if next_panel.has_method("reset"):
		next_panel.reset()
	current_panel = next_panel

func _on_IntroPanel_continue_button_pressed():
	_swipe_in($MenuContainer/InstructionsPanel)

func _on_InstructionsPanel_continue_button_pressed():
	_swipe_in($MenuContainer/SettingsPanel)

func _on_SettingsPanel_start_button_pressed():
	emit_signal("start_button_pressed")

func get_character_count():
	return $MenuContainer/SettingsPanel.character_count
	
func get_buyer_max_price():
	return $MenuContainer/SettingsPanel.buyer_max_price
	
func get_buyer_min_price():
	return $MenuContainer/SettingsPanel.buyer_min_price
	
func get_seller_max_price():
	return $MenuContainer/SettingsPanel.seller_max_price

func get_seller_min_price():
	return $MenuContainer/SettingsPanel.seller_min_price

func get_character_ratio():
	return $MenuContainer/SettingsPanel.character_ratio

func get_character_layout():
	return $MenuContainer/SettingsPanel.character_layout
