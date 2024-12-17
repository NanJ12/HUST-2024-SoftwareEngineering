#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name PurpleLightOrgan extends ContinuousOrgan

# TODO 紫光机关 ===============>信 号<===============
#region 信号

#endregion

# TODO 紫光机关 ===============>常 量<===============
#region 常量

#endregion

# TODO 紫光机关 ===============>变 量<===============
#region 变量

#endregion

# TODO 紫光机关 ===============>虚方法<===============
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

# TODO 紫光机关 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 紫光机关：玩家进入信号方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_in_purple_light = true


# TODO_FUC 紫光机关：玩家退出信号方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.is_in_purple_light = false
#endregion

# TODO 紫光机关 ===============>工具方法<===============
#region 工具方法

#endregion
