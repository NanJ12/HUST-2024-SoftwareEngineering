#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name StrengthModel extends Node

# TODO 体力模块 ===============>信 号<===============
#region 信号
signal strength_update(strength : float, max_strength : float)
signal is_tired
#endregion

# TODO 体力模块 ===============>常 量<===============
#region 常量

#endregion

# TODO 体力模块 ===============>变 量<===============
#region 变量
# 最大体力
@export var max_strength : float:
	set(v):
		max_strength = v
		strength_update.emit(strength, max_strength)
# 当前体力值
var strength : float:
	set(v):
		strength = v

		if strength <= 0:
			strength = 0
			is_tired.emit()
		if strength >= max_strength:
			strength = max_strength

		strength_update.emit(strength, max_strength)
# 玩家恢复速度
@export var strength_recover_speed : float = .8
#endregion

# TODO 体力模块 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	reset_strength()

func _ready() -> void:
	await get_tree().process_frame
	strength_update.emit(strength, max_strength)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 体力模块 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 体力模块 ===============>工具方法<===============
#region 工具方法
func reset_strength() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "strength", max_strength, .5)
#endregion
