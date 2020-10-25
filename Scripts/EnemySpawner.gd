extends Node2D

var positions = []
var spawn_map = {}

var spawn_cooldown = 500
var last_spawn_rotation = 0

var enemy_bp = preload("res://Prefabs/EnemyBody.tscn")
var spiral_shot = preload("res://Prefabs/SpiralShot.tscn")
var triple_shot = preload("res://Prefabs/TripleShot.tscn")
var normal_shot = preload("res://Prefabs/NormalShot.tscn")
var double_jump = preload("res://Prefabs/DoubleJump.tscn")

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    var nodes = get_children()
    for node in nodes:
        if node is Position2D:
            positions.append(node)
        pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if OS.get_system_time_msecs() > last_spawn_rotation + spawn_cooldown:
        _spawn()
        last_spawn_rotation = OS.get_system_time_msecs()


func _spawn():
    for pos in positions:
        if !spawn_map.has(pos.name):
            var enemy = enemy_bp.instance()
            enemy.drop = _select_drop()
            enemy.spawner = get_node(".")
            enemy.transform = pos.global_transform
            enemy.position_name = pos.name
            owner.add_child(enemy)
            spawn_map[pos.name] = "present"

func _select_drop() -> PackedScene:
    rng.randomize()
    var num = int(rng.randf_range(1, 64))

    if num % 8 == 0:
        return spiral_shot.instance()
    if num % 5 == 0:
        return triple_shot.instance()
    if num % 3 == 0:
        return normal_shot.instance()

    return null


func unregister(position_name):
    print("unregistered")
    spawn_map.erase(position_name)
    $Timer.start()


func _on_Timer_timeout():
    _spawn()
