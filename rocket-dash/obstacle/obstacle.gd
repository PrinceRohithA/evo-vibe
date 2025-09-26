extends Area2D

var operator: String
var value: int

signal hit(operator: String, value: int)

func _ready() -> void:
	var ops: Array[String] = ["+", "-", "*", "/"]
	operator = ops[randi() % ops.size()]
	value = randi_range(1, 9)
	$Label.text = operator + str(value)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Rocket": 
		emit_signal("hit", operator, value)
		queue_free()
