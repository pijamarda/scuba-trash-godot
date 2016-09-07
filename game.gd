
extends Node2D

var screen_size
var dude_size

#speed of the bone (in pixels/second)
var bone_speed = 150

#direction of the bone (normal vector)
var direction = Vector2(-1, 0)

#constant for dude speed (also in pixels/second)
const DUDE_SPEED = 150

func _ready():
	screen_size = get_viewport_rect().size
	dude_size = get_node("dude").get_texture().get_size()
	set_process(true)
	pass

func _process(delta):
	var bone_pos = get_node("bone").get_pos()
	var dude_rect = Rect2( get_node("dude").get_pos() - dude_size/2, dude_size )
	bone_pos += direction * bone_speed * delta
	
	if ( (bone_pos.y < 0 and direction.y < 0) or (bone_pos.y > screen_size.y and direction.y > 0)):
    	direction.y = -direction.y
	if (bone_pos.x < 0 or bone_pos.x > screen_size.x):
		direction.x = -direction.x
		bone_speed *= 1.1
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
		
	get_node("bone").set_pos(bone_pos)
	
	#move dude
	var dude_pos = get_node("dude").get_pos()
	
	if (dude_pos.y > 0 and Input.is_action_pressed("dude_move_up")):
		dude_pos.y += -DUDE_SPEED * delta
	if (dude_pos.y < screen_size.y and Input.is_action_pressed("dude_move_down")):
		dude_pos.y += DUDE_SPEED * delta
	if (dude_pos.x > 0 and Input.is_action_pressed("dude_move_left")):
		dude_pos.x += -DUDE_SPEED * delta
		get_node("dude").set_flip_h(true)
		get_node("dude").get_node("burbujas").set_pos(Vector2(0, -49))
	if (dude_pos.x < screen_size.x and Input.is_action_pressed("dude_move_right")):
		dude_pos.x += DUDE_SPEED * delta
		get_node("dude").set_flip_h(false)
	
	get_node("dude").set_pos(dude_pos)
