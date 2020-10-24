extends KinematicBody2D

export var speed_x = 20
export var gravity = 1000
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _hit():
    queue_free() # instant death request
