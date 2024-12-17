#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends Node

# TODO 全局 ===============>信 号<===============
#region 信号
signal war_of_pursuit
signal ready_safe_lumine
#endregion

# TODO 全局 ===============>常 量<===============
#region 常量
const TRAIL = preload("res://effect/trail.tscn")
const CD_PROP = preload("res://resource/props/cd_prop.tscn")
const MEMORY_PROP = preload("res://resource/props/memory_prop.tscn")
#endregion

# TODO 全局 ===============>变 量<===============
#region 变量
# 全局：定义全局场景过度的 shader 效果
var shader_index = 1

# 全局：传送点保存
var spawn_points : Dictionary = {"初始点" : Vector2(-360, 300)}

# 全局：玩家
var player : Player

# 全局：环境
var world_environment : WorldEnvironment

# 全局：颜色
var global_canvas_modulate: CanvasModulate

# 全局：玩家拥有颜色
var has_player_colors : Array[PlayerColor] = [preload("res://resource/player_colors/player_color_orange.tres")]
# 全局：玩家携带颜色
var player_colors : Array[PlayerColor] = [preload("res://resource/player_colors/player_color_white.tres"), preload("res://resource/player_colors/player_color_red.tres"), preload("res://resource/player_colors/player_color_cyan.tres")]

# 全局：玩家获得的回忆碎片
var memory_fragments : Array[MemoryFragment] = []

# 全局：是否与红光对话了
var red_dialogic_enabled : bool = false

# 全局：计时器
var ending_timer : Timer

# 全局：是否开始追逐战
var is_war_of_pursuit : bool = false:
	set(v):
		is_war_of_pursuit = v
		if is_war_of_pursuit:
			war_of_pursuit.emit()

var evil_lumine_is_relly_attack : bool = false:
	set(v):
		evil_lumine_is_relly_attack = v
		if evil_lumine_is_relly_attack:
			ready_safe_lumine.emit()

# 全局：跳跃教程
var learning_jumping : bool = false

# 全局：漂浮教程
var learning_gliding : bool = false

# 全局：冲刺教程
var learning_sprinting : bool = false

# 全局：是否加载存档
var is_load_save : bool = false

# 全局：是否加载指令
var is_command : bool = false

# 全局：是否显示提示
var key_tip_enabled : bool = true

# 全局：相机模式
var camera_mode_enabled : bool = true

# 全局：是否全屏
var full_screen_enabled : bool = false

# 全局：是否开启辉光
var glow_enabled : bool = true:
	set(v):
		glow_enabled = v
		if SceneManager.current_scene_index == 1:
			await get_tree().process_frame
			world_environment.environment.glow_enabled = glow_enabled

# 全局：音量
var main_volume : float = .6
var sfx_volume : float = 1
var bgm_volume : float = 1
var ambient_volume : float = 1

# 全局：是否静音
var is_main_volume : bool = false
var is_sfx_volume : bool = false
var is_bgm_volume : bool = false
var is_ambient_volume : bool = false
#endregion

# TODO 全局 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 全局 ===============>工具方法<===============
#region 工具方法

#endregion
