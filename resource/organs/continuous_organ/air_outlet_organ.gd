#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name AirOutletOrgan extends ContinuousOrgan

# TODO 机关：吹风口 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关：吹风口 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关：吹风口 ===============>变 量<===============
#region 变量

#endregion

# TODO 机关：吹风口 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 机关：吹风口 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：吹风口：玩家进入方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.player.is_light:
			body.gravity = -GlobalValue.gravity.rotated(rotation) * 4

# TODO_FUC 机关：吹风口：玩家退出方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.gravity = GlobalValue.gravity
#endregion

# TODO 机关：吹风口 ===============>工具方法<===============
#region 工具方法

#endregion
