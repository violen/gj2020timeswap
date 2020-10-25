extends KinematicBody2D

export var speed_x = 20
export var gravity = 1000
var velocity = Vector2.ZERO

export (PackedScene) var drop

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _hit():


    _drop()
    _die()

func _drop():
    var scene = drop.instance()
    scene.position = global_position
    scene.transform = global_transform
    owner.add_child(scene)

func _die():
    queue_free()
