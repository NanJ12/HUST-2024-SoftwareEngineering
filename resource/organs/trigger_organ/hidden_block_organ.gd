#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name HiddenBlockOrgan extends TriggerOrgan

# TODO 隐藏方块 ===============>信 号<===============
#region 信号

#endregion

# TODO 隐藏方块 ===============>常 量<===============
#region 常量

#endregion

# TODO 隐藏方块 ===============>变 量<===============
#region 变量
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
var _coll : CollisionShape2D
#endregion

# TODO 隐藏方块 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	_coll = collision_shape_2d.duplicate()

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 隐藏方块 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 隐藏方块 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 机关：隐藏方块：机关运行方法
func organ_run() -> void:
	if is_trigger:
		modulate.a = 0
		collision_shape_2d.set_deferred("disabled", true)
	else :
		modulate.a = 1
		collision_shape_2d.set_deferred("disabled", false)

#endregion
