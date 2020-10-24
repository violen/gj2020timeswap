extends KinematicBody2D

export var speed_x = 35
export var jump_force = 600
export var gravity = 1000
var velocity = Vector2.ZERO

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#     pass

func _move_Player(delta):

    # if velocity.length() > 0:
    #     velocity = velocity.normalized() * speed_x
    velocity.y += gravity * delta
    velocity = move_and_slide(velocity, Vector2.UP)

    if Input.is_action_just_pressed("jump"):
        velocity.y = -jump_force

func _get_input():
    if Input.is_action_pressed("run_right"):
        velocity.x += speed_x
    if Input.is_action_pressed("run_left"):
        velocity.x -= speed_x

func _physics_process(delta):
    _get_input()
    _move_Player(delta)


