#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name PlayerColorWhite extends PlayerColor

# TODO 玩家白色策略基类 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家白色策略基类 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家白色策略基类 ===============>变 量<===============
#region 变量

#endregion

# TODO 玩家白色策略基类 ===============>虚方法<===============
#region 常用的虚方法

#endregion

# TODO 玩家白色策略基类 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家白色策略基类 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 玩家白色策略基类：策略逻辑
func player_color_effect() -> void:
	Global.player.is_light = true
	Global.player.ex_gravity = Vector2.ZERO
	Global.player.speed = 350
	Global.player.sprint_speed = 1200
	Global.player.max_jump_speed = 500
	Global.player.normal_sprint_cd = 3.
	Global.player.is_fly = false
	color = Color.WHITE
#endregion
