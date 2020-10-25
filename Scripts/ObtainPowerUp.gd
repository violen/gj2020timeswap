extends Area2D

enum PowerUps {
    UNKNOWN,
    DOUBLE_JUMP,
    NORMAL_SHOT,
    TRIPLE_SHOT,
    SPIRAL_SHOT,
}

export var powerup = PowerUps.UNKNOWN

onready var tween_move_values = [-5, +5]

# Called when the node enters the scene tree for the first time.
func _ready():
    assert(powerup != PowerUps.UNKNOWN, "Please set a PowerUp Type in the Editor")
    _start_tween_animation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_collected():
    match powerup:
        PowerUps.DOUBLE_JUMP:
            GameGlobals.canDoubleJump = true
        PowerUps.NORMAL_SHOT:
            GameGlobals.currentShotType = GameGlobals.NORMAL_SHOT
        PowerUps.TRIPLE_SHOT:
            GameGlobals.currentShotType = GameGlobals.TRIPLE_SHOT
        PowerUps.SPIRAL_SHOT:
            GameGlobals.currentShotType = GameGlobals.SPIRAL_SHOT
        _:
            print("unknown powerup")

func _on_Area2D_body_entered(body):
    if body.name.find("Player") >= 0:
        _on_collected()
        queue_free()

func _start_tween_animation():
    $Tween.interpolate_property(
        self,
        "position:y",
        tween_move_values[0], tween_move_values[1], .75,
        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    $Tween.start()

func _on_Tween_tween_completed(_object, _key):
    tween_move_values.invert()
    _start_tween_animation()