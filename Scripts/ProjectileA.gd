extends Area2D

export var speed = 300
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func _bullet_direction(direction):
    if(self.direction == Vector2(-1, 0)):
        $Sprite.flip_h = true
    else:
        $Sprite.flip_h = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#    move_local_x(delta * speed)

func _physics_process(delta):
    # TODO: Rotate sprite to reflect direction
    position += Vector2(direction.x * speed * delta, 0)

func _on_ProjectileA_area_entered(area):
    if area.get_collision_layer_bit(1):
        queue_free()

func _on_ProjectileA_body_entered(body):
    if body.name.find("Enemy") >= 0:
        body._hit()
    if body.name.find("Player") >= 0:
        return
    queue_free()
