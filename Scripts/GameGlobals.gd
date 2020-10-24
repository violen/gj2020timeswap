extends Node

## GAME

var isGameOver = false
var platform = OS.get_name()

## PROGRESS

var canDoubleJump = false

func _is_mobile() -> bool:
    match platform:
        "Android":
            return true
        _:
            return false
