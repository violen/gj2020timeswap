extends KinematicBody2D

export var speed_x = 35
export var jump_force = 600
export var gravity = 1000
var velocity = Vector2.ZERO
var direction = Vector2(1, 0)

var is_mid_air = false

enum {MELEE, RANGE, UNARMED}

var weapon_type = MELEE

export var switch_weapon_cooldown = 0
var last_weapon_switch = 0

export (PackedScene) var Projectile

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    _get_input()
    _move_Player(delta)

func _physics_process(delta):
    if direction != Vector2.ZERO:
        $Melee.cast_to = direction.normalized() * 30

func _move_Player(delta):

    # if velocity.length() > 0:
    #     velocity = velocity.normalized() * speed_x
    velocity.y += gravity * delta
    velocity = move_and_slide(velocity, Vector2.UP)

    _check_and_perform_jump()

func _get_input():
    if Input.is_action_pressed("run_right"):
        direction.x = 1
        velocity.x += speed_x
    if Input.is_action_pressed("run_left"):
        direction.x = -1
        velocity.x -= speed_x
    if Input.is_action_just_pressed("attack"):
        _attack()
    if Input.is_action_just_pressed("switch_weapon"):
        _switch_weapon()

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
    var target = $Melee.get_collider()
    if target != null:
        target._hit()

func _perform_range_attack():
    var projectile = null
    match GameGlobals.currentShotType:
        GameGlobals.NORMAL_SHOT:
            projectile = preload("res://Prefabs/ProjectileA.tscn")
        GameGlobals.TRIPLE_SHOT:
            # TODO: change to projectile B
            projectile = preload("res://Prefabs/ProjectileA.tscn")
        GameGlobals.SPIRAL_SHOT:
            # TODO: change to projectile C
            projectile = preload("res://Prefabs/ProjectileA.tscn")
        _:
            print("unknown Shot")
    var bullet = projectile.instance()
    get_node("/root/").add_child(bullet)
    bullet.global_position = $Position2D.global_position
    bullet.direction = direction

func _switch_weapon():
    if OS.get_system_time_msecs() > last_weapon_switch + switch_weapon_cooldown:
        last_weapon_switch = OS.get_system_time_msecs()
    else:
        return

    match weapon_type:
        MELEE:
            weapon_type = RANGE
            $SwitchWeapon.play()
            $Melee.enabled = false
        RANGE:
            weapon_type = MELEE
            $SwitchWeapon.play()
            $Melee.enabled = true
        _:
            print("unsuported weapon")
