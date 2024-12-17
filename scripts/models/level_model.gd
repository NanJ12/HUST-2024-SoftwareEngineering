#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name LevelModel extends Node

# TODO 等级模块 ===============>信 号<===============
#region 信号
signal level_up(level : int)
signal exp_update(exp : float, max_exp: float)
#endregion

# TODO 等级模块 ===============>常 量<===============
#region 常量
const MAX_LEVEL = 50
#endregion

# TODO 等级模块 ===============>变 量<===============
#region 变量
var level : int:
	set(v):
		level = v
		if level >= MAX_LEVEL:
			level = 50
			return
		level_up.emit(level)
var max_exp : float = 10
var e_x_p : float:
	set(v):
		e_x_p = v
		if e_x_p >= max_exp:
			level += 1
			# FIXME 这里是经验模块的经验公式，写了一个很烂的公式，之后改
			max_exp = level * 15
			e_x_p = 0
		if level == MAX_LEVEL: return
		exp_update.emit(e_x_p, max_exp)
#endregion

# TODO 等级模块 ===============>虚方法<===============
#region 常用的虚方法

#endregion

# TODO 等级模块 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 等级模块 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 等级模块：初始化
func reset_level() -> void:
	level = 0
	e_x_p = 0
#endregion
