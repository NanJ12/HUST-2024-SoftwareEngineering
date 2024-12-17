class_name Camera extends Camera2D

# TODO 相机 ===============>信 号<===============
#region 信号
# HACK 相机旋转发出的信号
#signal camera_rotated(rotation_index : int)
#endregion

# TODO 相机 ===============>常 量<===============
#region 常量
var MAX_DISTANCE = 150
#endregion

# TODO 相机 ===============>变 量<===============
#region 变量
@export var player : Player
@export var shake : bool = false
var speed : float = 20.
var shake_scale : float = 10.
var time : float = 0

var target_distance : float = 0

#endregion

# TODO 相机 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Global.camera_mode_enabled:
		var direction = player.global_position.direction_to(get_global_mouse_position())
		var target_pos = player.global_position + direction * target_distance

		target_distance = player.global_position.distance_to(get_global_mouse_position()) / 2

		target_pos = target_pos.clamp(
			player.global_position - Vector2(MAX_DISTANCE, MAX_DISTANCE / 2),
			player.global_position + Vector2(MAX_DISTANCE, MAX_DISTANCE / 2)
		)

		global_position = target_pos
	else :
		global_position = player.global_position

func _physics_process(_delta: float) -> void:
	if shake:
		time += 1
		var final_pos : Vector2 = Vector2(sin(time) * shake_scale, sin(time) * shake_scale)
		offset.x = lerp(offset.x, final_pos.x, .2)
		offset.y = lerp(offset.y, final_pos.y, .2)
	elif time:
		time = 0

func _input(_event: InputEvent) -> void:
	pass


func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 相机 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 相机 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 相机：相机震动效果
func shake_camera(_time : float, _shake_scale : float) -> void:
	shake_scale = _shake_scale
	shake = true
	get_tree().create_timer(_time).timeout.connect(func(): shake = false)
#endregion
