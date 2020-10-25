extends KinematicBody2D

export var speed_x = 20
export var gravity = 1000
var velocity = Vector2.ZERO

var drop

var position_name = ""
var spawner = null

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
    if drop != null:
        drop.position = global_position
        drop.transform = global_transform
        get_tree().get_root().add_child(drop)

func _die():
    if spawner != null:
        spawner.unregister(position_name)
        spawner = null
    queue_free()
