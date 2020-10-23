extends KinematicBody2D

var xVel = 500
var yVel = 1
export var grav = 1000
var jump_counter = 0
var mid_air_jumps = 0
var is_jumping = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var movement = 0
	
	if(Input.is_action_pressed("run_right")):
		movement += 1
		
	if(Input.is_action_pressed("run_left")):
		movement -= 1
		
	if(Input.is_action_just_pressed("jump")):
		if(self.is_on_floor() || jump_counter <= mid_air_jumps):
			yVel = -700
			jump_counter += 1
			is_jumping = true
		else:
			is_jumping = false

	move_and_slide(Vector2(movement * xVel, yVel), Vector2(0, -1))
	
	if(self.is_on_floor()):
		yVel = 5
		jump_counter = 0
	else:
		yVel += grav * delta
	yVel = clamp(yVel, -1500, 1500)
