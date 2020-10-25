extends Area2D

export var speed = 350
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
func _spread_rotation(direction):
    if(direction == Vector2(1, 1)):
        rotation_degrees = 45
    elif(direction == Vector2(1, -1)):
        rotation_degrees = -45
    elif(direction == Vector2(-1, 1)):
        rotation_degrees = -45 - 180
    elif(direction == Vector2(-1, 0)):
        rotation_degrees = 180
    elif(direction == Vector2(-1, -1)):
        rotation_degrees = 45 + 180

func _physics_process(delta):
    # TODO: Rotate sprite to reflect direction
    position += Vector2(direction.x * speed * delta, direction.y * speed * delta)

func _on_ProjectileB_area_entered(area):
    if area.get_collision_layer_bit(1):
        queue_free()

func _on_ProjectileB_body_entered(body):
    if body.name.find("Enemy") >= 0:
        body._hit()
    if body.name.find("Player") >= 0:
        return
    queue_free()
