extends CanvasModulate

@export var gradient: GradientTexture1D
var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	var value = (sin(time - PI / 2 ) + 1.0 ) / 2.0
