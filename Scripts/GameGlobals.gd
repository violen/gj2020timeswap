extends Node

## GAME

var isGameOver = false
var platform = OS.get_name()

## PROGRESS

var canDoubleJump = false

enum {NORMAL_SHOT, TRIPLE_SHOT, SPIRAL_SHOT}

var currentShotType = NORMAL_SHOT

var canLeave80s = false
var canLeaveFuture = false
var canLeaveMedieval = false

func _is_mobile() -> bool:
    match platform:
        "Android":
            return true
        _:
            return false
