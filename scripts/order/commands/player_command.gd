class_name PlayerCommand extends Command

# TODO 玩家命令集 ===============>变 量<===============
#region 变量
var player : Node
#endregion

# TODO 玩家命令集 ===============>类中类<===============
#region 类中类
class HealthCommand extends PlayerCommand:
	var health : float

	func _init(_player : Node, _health : float) -> void:
		player = _player
		health = _health

	func excute() -> void:
		player.health_model.health = health

class StrengthCommand extends PlayerCommand:
	var strength : float

	func _init(_player : Node, _strength : float) -> void:
		player = _player
		strength = _strength

	func excute() -> void:
		player.strength_model.strength = strength

class JumpSpeedCommand extends PlayerCommand:
	var jump_speed : float

	func _init(_player : Node, _jump_speed : float) -> void:
		player = _player
		jump_speed = _jump_speed

	func excute() -> void:
		player.jump_speed = jump_speed

class SpeedCommand extends PlayerCommand:
	var speed : float

	func _init(_player : Node, _speed : float) -> void:
		player = _player
		speed = _speed

	func excute() -> void:
		player.speed = speed

class TPCommand extends PlayerCommand:
	var global_position : Vector2

	func _init(_player : Node, _global_position : Vector2) -> void:
		player = _player
		global_position = _global_position

	func excute() -> void:
		player.global_position = global_position
#endregion

# TODO 玩家命令集 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家命令集 ===============>工具方法<===============
#region 工具方法

#endregion
