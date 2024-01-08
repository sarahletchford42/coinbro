extends Area2D

signal pickup
signal hurt

@export var speed = 350

var velocity = Vector2.ZERO
var screensize = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get vector representing the Player's input
	# then move and clamp the position inside the screen
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	# Determine which anim to play
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if velocity.x != 0: 
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
func start():
	# This func resets player for a new game
	set_process(true)
	position = screensize / 2 
	$AnimatedSprite2D.animation = "idle"
	
func die():
	# call this func when player ded
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)


func _on_area_entered(area):
	# when collide w an object, decide what do
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")
	if area.is_in_group("obstacles"):
		position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))
		hurt.emit()
		die()
