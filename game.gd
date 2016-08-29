
extends Node2D

var screen_size
var dog_size

#speed of the bone (in pixels/second)
var bone_speed = 150

#direction of the bone (normal vector)
var direction = Vector2(-1, 0)

#constant for dog speed (also in pixels/second)
const DOG_SPEED = 150

func _ready():
	screen_size = get_viewport_rect().size
	dog_size = get_node("dog").get_texture().get_size()
	set_process(true)
	pass

func _process(delta):
	var bone_pos = get_node("bone").get_pos()
	var dog_rect = Rect2( get_node("dog").get_pos() - dog_size/2, dog_size )
	bone_pos += direction * bone_speed * delta
	
	if ( (bone_pos.y < 0 and direction.y < 0) or (bone_pos.y > screen_size.y and direction.y > 0)):
    	direction.y = -direction.y
	if (bone_pos.x < 0 or bone_pos.x > screen_size.x):
		direction.x = -direction.x
		bone_speed *= 1.1
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
		
	get_node("bone").set_pos(bone_pos)
	
	#move dog
	var dog_pos = get_node("dog").get_pos()
	
	if (dog_pos.y > 0 and Input.is_action_pressed("dog_move_up")):
	    dog_pos.y += -DOG_SPEED * delta
	if (dog_pos.y < screen_size.y and Input.is_action_pressed("dog_move_down")):
	    dog_pos.y += DOG_SPEED * delta
	if (dog_pos.x > 0 and Input.is_action_pressed("dog_move_left")):
	    dog_pos.x += -DOG_SPEED * delta
	if (dog_pos.x < screen_size.x and Input.is_action_pressed("dog_move_right")):
	    dog_pos.x += DOG_SPEED * delta
	
	get_node("dog").set_pos(dog_pos)
