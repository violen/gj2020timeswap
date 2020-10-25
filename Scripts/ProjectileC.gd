extends Area2D

export var speed = 250
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

const max_velocity = Vector2(0, 1500)
const accel = Vector2(0, 100)

var loop_cooldown = 250
var last_loop_done = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#    move_local_x(delta * speed)

func _physics_process(delta):

    if OS.get_system_time_msecs() > last_loop_done + loop_cooldown:
        # _do_a_barrel_roll(delta)
        last_loop_done = OS.get_system_time_msecs()

    velocity.y = sin(position.x * delta * 4.5) * speed
    velocity.x = speed
    velocity.x = clamp(velocity.x, -speed, speed)

    position += velocity * delta * direction.x
    # position += Vector2(direction.x * speed * delta, 0)

func _on_ProjectileC_area_entered(area):
    if area.get_collision_layer_bit(1):
        queue_free()

func _on_ProjectileC_body_entered(body):
    if body.name.find("Enemy") >= 0:
        body._hit()
    if body.name.find("Player") >= 0:
        return
    queue_free()


func _do_a_barrel_roll(delta):
    position += Vector2(0 , cos(delta * 20) * 0.5)
