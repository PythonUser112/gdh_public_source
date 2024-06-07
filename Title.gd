extends AnimationPlayer

func start():
	play("ScreenIntro")
	yield(self, "animation_finished")
	$ColorRect.hide()
	$ColorRect2.hide()
	$Label.hide()
	$Sprite.hide()
	play("FadeIn")
	yield(self, "animation_finished")
	queue_free()
