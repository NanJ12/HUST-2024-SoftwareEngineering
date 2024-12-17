class_name HealthModel extends Node

# TODO 生命模块 ===============>信 号<===============
#region 信号
signal health_update(health : float, max_health : float)
signal is_dead
#endregion

# TODO 生命模块 ===============>常 量<===============
#region 常量

#endregion

# TODO 生命模块 ===============>变 量<===============
#region 变量
# 最大生命
@export var max_health : float:
	set(v):
		max_health = v
		health_update.emit(health, max_health)
# 当前生命
var health : float:
	set(v):
		health = v

		if health <= 0:
			health = 0
			is_dead.emit()
		if health >= max_health:
			health = max_health

		health_update.emit(health, max_health)
#endregion

# TODO 生命模块 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	reset_health()

func _ready() -> void:
	await get_tree().process_frame
	health_update.emit(health, max_health)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 生命模块 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 生命模块 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 生命模块：生命初始化
func reset_health() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "health", max_health, .5)

#endregion
