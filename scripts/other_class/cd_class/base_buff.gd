#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name BaseBuff extends Resource

# TODO Buff 类 ===============>信 号<===============
#region 信号

#endregion

# TODO Buff 类 ===============>常 量<===============
#region 常量

#endregion

# TODO Buff 类 ===============>变 量<===============
#region 变量
# Buff 类：Buff 的名字
@export var buff_name : String
# Buff 类：Buff 的等级
@export var buff_level : int
# Buff 类：Buff 的介绍
@export_multiline var buff_desc : String
# Buff 类：Buff 的图标
@export var buff_texture : AtlasTexture
#endregion

# TODO Buff 类 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO Buff 类 ===============>工具方法<===============
#region 工具方法
# TODO_FUC Buff 类：Buff逻辑
func buff_effect() -> void:
	pass
#endregion
