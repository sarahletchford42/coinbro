extends Area2D

var screensize = Vector2.ZERO


func pickup():
	queue_free()
	
func _ready():
	$Timer.start(randf_range(3,8))
	
func _on_timer_timeout():
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play()
	
