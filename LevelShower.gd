extends Node2D

signal pressed

var level

func init(level_name, norm_progress, practise_progress, level_type, level_color):
	$MainContainer/DataContainer/Level/LevelType.emoji_name = level_type
	$MainContainer/DataContainer/Level/NameLabel.text = level_name
	$MainContainer/DataContainer/Level/NameLabel.icon = $MainContainer/DataContainer/Level/LevelType.texture
	$MainContainer/DataContainer/Margin/ProgressContainer/NormalMode/Progress.value = norm_progress
	$MainContainer/DataContainer/Margin/ProgressContainer/PractiseMode/Progress.value = practise_progress
	$ColorRect.color = level_color
	$MainContainer/DataContainer/Margin/ProgressContainer/NormalMode/ProgressLabel.text = str(norm_progress)
	$MainContainer/DataContainer/Margin/ProgressContainer/PractiseMode/ProgressLabel.text = str(practise_progress)
	show()
	level = level_name


func _on_NameLabel_pressed():
	emit_signal("pressed", level)
