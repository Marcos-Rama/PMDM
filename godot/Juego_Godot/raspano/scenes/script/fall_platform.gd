extends RigidBody2D

# Referencia al Timer
@onready var timer = $Timer



func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Main_char":
		%Timer.start()


func _on_timer_timeout() -> void:
	set_deferred("freeze",false) # Replace with function body.
	$"Eliminación_recursos".start()


func _on_eliminación_recursos_timeout() -> void:
	queue_free()# Replace with function body.
