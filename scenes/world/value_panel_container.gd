#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name ValuePanelContainer extends PanelContainer

# TODO 属性UI ===============>信 号<===============
#region 信号

#endregion

# TODO 属性UI ===============>常 量<===============
#region 常量

#endregion

# TODO 属性UI ===============>变 量<===============
#region 变量
# 获取玩家
@onready var player: Player = %Player
# 玩家血量 UI 的容器
@onready var player_health_progress_bar: ProgressBar = %PlayerHealthProgressBar
# 玩家体力 UI 的容器
@onready var player_strength_progress_bar: ProgressBar = %PlayerStrengthProgressBar
# 等级文字 UI 的容器
@onready var level_label: Label = %LevelLabel
# 玩家经验 UI 的容器
@onready var player_exp_progress_bar: ProgressBar = %PlayerExpProgressBar
# WARNING 测试用，后面记得删掉
@onready var fps_label: Label = $"../FPSLabel"
# 游戏暂停界面：初始位置
var current_pos : Vector2
#endregion

# TODO 属性UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	player.strength_model.strength_update.connect(_on_strength_model_strength_update)
	player.health_model.health_update.connect(_on_health_model_health_update)
	player.level_model.exp_update.connect(_on_level_model_exp_update)
	player.level_model.level_up.connect(_on_level_model_level_up)

	# WARNING 注意：这里的这行代码是对等级文字做初始化
	level_label.text = "%s" % (GlobalValue.player_level + 1)

	if not current_pos:
		current_pos = global_position

	global_position.y = current_pos.y - 1000
	await UiTool.ui_enter(self, current_pos)

func _process(_delta: float) -> void:
	fps_label.text = "FPS：%s， Position：%s" % [Performance.get_monitor(Performance.Monitor.TIME_FPS), Vector2i(Global.player.global_position)]

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 属性UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 属性UI：亮度 UI 更新信号方法
func _on_health_model_health_update(health : float, max_health : float) -> void:
	player_health_progress_bar.max_value = max_health
	player_health_progress_bar.value = health

# # TODO_FUC 属性UI：体力 UI 更新信号方法
func _on_strength_model_strength_update(strength : float, max_strength : float) -> void:
	player_strength_progress_bar.max_value = max_strength
	player_strength_progress_bar.value = strength

# FIXME 这里还没写
# TODO_FUC 属性UI：经验 UI 更新信号方法
func _on_level_model_exp_update(_exp : float, max_exp) -> void:
	player_exp_progress_bar.max_value = max_exp
	player_exp_progress_bar.value = _exp

# TODO_FUC 属性UI：等级文字 UI 更新信号方法
func _on_level_model_level_up(level : int) -> void:
	level_label.text = "%s" % (level + 1)
#endregion

# TODO 属性UI ===============>工具方法<===============
#region 工具方法

#endregion
