extends PanelContainer

## The icon shown on the screen.
const ICON: Texture2D = preload("res://assets/icons/point.png")

const POINT_COUNT: int = 20

func _ready() -> void:
	# Make Point
	for x in range(POINT_COUNT):
		var sprt: Sprite2D = Sprite2D.new()
		sprt.texture = ICON
		
		var lower: Vector2 = get_rect().position
		var upper: Vector2 = get_rect().size + lower
		add_child(sprt)
		
		sprt.global_position = Vector2(randf_range(lower.x, upper.x), randf_range(upper.y, lower.y)) 
