extends CanvasLayer

func _process(_delta):
	%Credits.text = "CREDITS: " + str(GLOBAL.credit)
	%Score.text = "SCORE: " + str(GLOBAL.score)
