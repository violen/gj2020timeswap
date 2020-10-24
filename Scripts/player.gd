extends KinematicBody2D

export var speed_x = 35
export var jump_force = 600
export var gravity = 1000
var velocity = Vector2.ZERO

var is_mid_air = false
var jump_sound = ResourceLoader.load("res://Assets/Sounds/jump.ogg")

enum {MELEE, RANGE}

var weapon_type = MELEE

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    _get_input()
    _move_Player(delta)

func _move_Player(delta):

    # if velocity.length() > 0:
    #     velocity = velocity.normalized() * speed_x
    velocity.y += gravity * delta
    velocity = move_and_slide(velocity, Vector2.UP)

    _check_and_perform_jump()

func _get_input():
    if Input.is_action_pressed("run_right"):
        velocity.x += speed_x
    if Input.is_action_pressed("run_left"):
        velocity.x -= speed_x
    if Input.is_action_just_pressed("attack"):
        _attack()

func _check_and_perform_jump():
    if Input.is_action_just_pressed("jump"):
        if GameGlobals.canDoubleJump && is_mid_air:
            $Jump.play()
            velocity.y = -jump_force
            is_mid_air = false

        if is_on_floor():
            $Jump.play()
            velocity.y = -jump_force
            is_mid_air = true

func _attack():
    match weapon_type:
        MELEE:
            _perform_melee_attack()
        RANGE:
            _perform_range_attack()
        _:
            return


func _perform_melee_attack():
    if !$Slap.is_playing():
        $Slap.play()

func _perform_range_attack():
    pass
