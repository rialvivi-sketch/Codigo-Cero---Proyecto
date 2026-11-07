extends CanvasLayer

func _process(_delta):
	%credits.text = "CREDITS: " + str(GLOBAL.credits)
	%score.text = "SCORE: " + str(GLOBAL.score)
