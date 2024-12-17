class_name CreateCommand extends Command

const MOVABLE_BLOCK_ORGAN = preload("res://resource/organs/continuous_organ/movable_block_organ.tscn")
const RAY_POINT_ORGAN = preload("res://resource/organs/continuous_organ/ray_point_organ.tscn")
const ROLLING_STONES_ORGAN = preload("res://resource/organs/continuous_organ/rolling_stones_organ.tscn")

# TODO 玩家命令集 ===============>变 量<===============
#region 变量
var player : Node
#endregion

# TODO 玩家命令集 ===============>类中类<===============
#region 类中类
class MovableBlockCommand extends CreateCommand:
	var number : int

	func _init(_player : Node, _number : int) -> void:
		player = _player
		number = _number

	func excute() -> void:
		for i in number:
			var organ : Organ = MOVABLE_BLOCK_ORGAN.instantiate()
			organ.global_position = player.global_position + Vector2(96, -192 - i * 48) * player.last_dir
			player.get_parent().get_node("OrganEX").add_child(organ)

class RollingStoneCommand extends CreateCommand:
	var number : int

	func _init(_player : Node, _number : int) -> void:
		player = _player
		number = _number

	func excute() -> void:
		for i in number:
			var organ : Organ = ROLLING_STONES_ORGAN.instantiate()
			organ.global_position = player.global_position + Vector2(96, -192 - i * 48) * player.last_dir
			player.get_parent().get_node("OrganEX").add_child(organ)

class RayLightCommand extends CreateCommand:
	var number : int

	func _init(_player : Node, _number : int) -> void:
		player = _player
		number = _number

	func excute() -> void:
		for i in number:
			var organ : Organ = RAY_POINT_ORGAN.instantiate()
			organ.global_position = player.global_position + Vector2(96, -192 - i * 48) * player.last_dir
			player.get_parent().get_node("OrganEX").add_child(organ)
#endregion

# TODO 玩家命令集 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家命令集 ===============>工具方法<===============
#region 工具方法

#endregion
