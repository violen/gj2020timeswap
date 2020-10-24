extends Node

var isGameOver = false
var platform = OS.get_name()

func _is_mobile() -> bool:
    match platform:
        "Android":
            return true
        _:
            return false
