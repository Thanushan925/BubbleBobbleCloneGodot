extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_score(value : int):
	$ScoreLabel.text = "Score: " + str(value)

func update_lives(value : int):
	$LivesLabel.text = "Lives: " + str(value)

func show_game_over():
	$GameOverLabel.visible = true

func show_win():
	$WinLabel.visible = true
