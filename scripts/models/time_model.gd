# TODO 时间模块
class_name TimeModel extends Node

# TODO 时间模块 ===============>信 号<===============
#region 信号
signal update_time(day : int, hour : int, minutes : int)
#endregion

# TODO 时间模块 ===============>常 量<===============
#region 常量
# 每小时多少分钟
const HOUR : int = 60
# 每天多少小时
const DAY : int = 24
#endregion

# TODO 时间模块 ===============>变 量<===============
#region 变量
# 时间计算
var time : float = 0
# 分钟
var current_minutes : int:
	set(v):
		current_minutes = v
		if current_minutes == HOUR:
			current_minutes = 0
			current_hour += 1
		update_time.emit(current_day, current_hour, current_minutes)
# 时
var current_hour : int:
	set(v):
		current_hour = v
		if current_hour == DAY:
			current_hour = 0
			current_day += 1
# 天
var current_day : int
#endregion

# TODO 时间模块 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	current_minutes = 0
	current_hour = 23
	current_day = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	time += delta
	if time >= 1:
		time = 0
		current_minutes += 5

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 时间模块 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 时间模块 ===============>工具方法<===============
#region 工具方法

#endregion
