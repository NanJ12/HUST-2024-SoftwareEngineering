#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name HealthBuff extends BaseBuff

# TODO 生命 Buff 类 ===============>信 号<===============
#region 信号

#endregion

# TODO 生命 Buff 类 ===============>常 量<===============
#region 常量

#endregion

# TODO 生命 Buff 类 ===============>变 量<===============
#region 变量

#endregion

# TODO 生命 Buff 类 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 生命 Buff 类 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 生命 Buff 类：Buff逻辑
func buff_effect() -> void:
	GlobalValue.health_buff_level = buff_level
#endregion
