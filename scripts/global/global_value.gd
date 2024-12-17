#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends Node

# TODO 全局属性 ===============>信 号<===============
#region 信号
signal value_update
signal buff_update
#endregion

# TODO 全局属性 ===============>常 量<===============
#region 常量
# 全局属性：最大玩家等级
const MAX_PLAYER_LEVEL : int = 50
# 全局属性：最大技能等级
const MAX_PLAYER_SKILL_LEVEL : int = 5

# 全局属性：每级 buff 提升的亮度比例
const HEALTH_BUFF_RADIO : float = .1
# 全局属性：每级 buff 提升的冲刺距离
const SPRINT_BUFF_RADIO : float = .1
# 全局属性：每级 buff 提升体力比例
const ABUNDANT_BUFF_RADIO : float = .1
# 全局属性：每级 buff 减少冲刺cd比例
const CONTINUE_SPRINT_BUFF_RADIO : float = .15
# 全局属性：每级 buff 减少的下落速度
const FEATHER_FALL_BUFF_RADIO : float = .15
# 全局属性：每级 buff 增加的强电比例
const RAY_DESTROY_BUFF_RADIO : float = .4
#endregion

# TODO 全局属性 ===============>变 量<===============
#region 变量
# 定义全局重力
var gravity : Vector2 = Vector2(0, 9.8)

#region 技能树相关属性
# 全局属性：技能点
var skill_point : int = 0:
	set(v):
		skill_point = v
		if skill_point <= 0:
			skill_point = 0

# 全局属性：已使用技能点
var used_skill_point : int = 0:
	set(v):
		used_skill_point = v

# 全局属性：玩家等级
var player_level : int = 1:
	set(v):
		player_level = v
		if player_level >= MAX_PLAYER_LEVEL:
			player_level = MAX_PLAYER_LEVEL

# 全局属性：玩家亮度
var player_luminance_level : int = 0:
	set(v):
		player_luminance_level = v
		if player_luminance_level >= MAX_PLAYER_SKILL_LEVEL:
			player_luminance_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家体力
var player_strength_level : int = 0:
	set(v):
		player_strength_level = v
		if player_strength_level >= MAX_PLAYER_SKILL_LEVEL:
			player_strength_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家冲刺
var player_sprint_cd_level : int = 0:
	set(v):
		player_sprint_cd_level = v
		if player_sprint_cd_level >= MAX_PLAYER_SKILL_LEVEL:
			player_sprint_cd_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家跳跃高度
var player_jump_height_level : int = 0:
	set(v):
		player_jump_height_level = v
		if player_jump_height_level >= MAX_PLAYER_SKILL_LEVEL:
			player_jump_height_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家体力回复
var player_strength_recover_level : int = 0:
	set(v):
		player_strength_recover_level = v
		if player_strength_recover_level >= MAX_PLAYER_SKILL_LEVEL:
			player_strength_recover_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家血量降低
var player_health_expend_level : int = 0:
	set(v):
		player_health_expend_level = v
		if player_health_expend_level >= MAX_PLAYER_SKILL_LEVEL:
			player_health_expend_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家体力降低
var player_strength_expend_level : int = 0:
	set(v):
		player_strength_expend_level = v
		if player_strength_expend_level >= MAX_PLAYER_SKILL_LEVEL:
			player_strength_expend_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家吸附下滑速度
var player_adsorp_down_level : int = 0:
	set(v):
		player_adsorp_down_level = v
		if player_adsorp_down_level >= MAX_PLAYER_SKILL_LEVEL:
			player_adsorp_down_level = MAX_PLAYER_SKILL_LEVEL
		value_update.emit()

# 全局属性：玩家空中转体
var can_air_twist : bool = false

# 全局属性：玩家二段跳
var can_double_jump : bool = false

# 全局属性：玩家吸附
var can_adsorption_jump : bool = false

# 全局属性：玩家破坏激光
var can_ray_destory : bool = false

# 全局属性：玩家交互激光
var can_ray_interact : bool = false
#endregion

# 全局属性：亮度提升Buff
var health_buff_level : int = 0:
	set(v):
		health_buff_level = v
		buff_update.emit()

# 全局属性：冲刺距离Buff
var sprint_buff_level : int = 0:
	set(v):
		sprint_buff_level = v
		buff_update.emit()

# 全局属性：充沛Buff
var abundant_buff_level : int = 0:
	set(v):
		abundant_buff_level = v
		buff_update.emit()

# 全局属性：连冲Buff
var continue_sprint_buff_level : int = 0:
	set(v):
		continue_sprint_buff_level = v
		buff_update.emit()

# 全局属性：羽落Buff
var feather_fall_buff_level : int = 0:
	set(v):
		feather_fall_buff_level = v
		buff_update.emit()

# 全局属性：强电buff
var ray_destroy_time_level : int = 0:
	set(v):
		ray_destroy_time_level = v
		buff_update.emit()

#endregion

# TODO 全局属性 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 全局属性 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 全局属性：重置属性
func reset() -> void:
	player_luminance_level = 0
	player_strength_level = 0
	player_health_expend_level = 0
	player_strength_expend_level = 0
	player_jump_height_level = 0
	player_strength_recover_level = 0
	player_health_expend_level = 0
	player_adsorp_down_level = 0
	skill_point += used_skill_point
	used_skill_point = 0
	can_air_twist = false
	can_double_jump = false
	can_adsorption_jump = false

# TODO_FUC 全局属性：重置buff
func reset_buff() -> void:
	health_buff_level = 0
	sprint_buff_level = 0
	abundant_buff_level = 0
	continue_sprint_buff_level = 0

# TODO_FUC 全局属性：是否有技能点
func has_skill_point() -> bool:
	return skill_point > 0

# TODO_FUC 全局属性：是否有已使用技能点
func has_used_skill_point() -> bool:
	return used_skill_point > 0
#endregion
