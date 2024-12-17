#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name Organ extends CharacterBody2D

# TODO 机关类 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关类 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关类 ===============>变 量<===============
#region 变量
# 机关名字
@export var organ_name : String
# 机关介绍
@export_multiline var organ_desc : String
# 机关贴图
@export var organ_texture : Texture2D
#endregion

# TODO 机关类 ===============>虚方法<===============
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

# TODO 机关类 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 机关类 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 机关类：机关运行方法
func organ_run() -> void:
	pass
#endregion
