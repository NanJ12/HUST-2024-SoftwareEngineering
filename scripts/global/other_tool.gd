#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends Node

# TODO 其他工具 ===============>信 号<===============
#region 信号

#endregion

# TODO 其他工具 ===============>常 量<===============
#region 常量

#endregion

# TODO 其他工具 ===============>变 量<===============
#region 变量

#endregion

# TODO 其他工具 ===============>虚方法<===============
#region 常用的虚方法

#endregion

# TODO 其他工具 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 其他工具 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 其他工具：时间修改工具方法
func time_scale_change(time_scale : float) -> void:
	Engine.time_scale = time_scale
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(Engine, "time_scale", 1, .25)
#endregion
