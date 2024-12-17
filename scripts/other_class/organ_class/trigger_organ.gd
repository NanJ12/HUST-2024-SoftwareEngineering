#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name TriggerOrgan extends Organ

# TODO 触发机关 ===============>信 号<===============
#region 信号

#endregion

# TODO 触发机关 ===============>常 量<===============
#region 常量

#endregion

# TODO 触发机关 ===============>变 量<===============
#region 变量
var is_trigger : bool = false:
	set(v):
		is_trigger = v
		organ_run()
#endregion

# TODO 触发机关 ===============>虚方法<===============
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

# TODO 触发机关 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 触发机关 ===============>工具方法<===============
#region 工具方法

#endregion
