#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name StopPanelContainer extends PanelContainer

# TODO 游戏暂停页面 ===============>信 号<===============
#region 信号

#endregion

# TODO 游戏暂停页面 ===============>常 量<===============
#region 常量

#endregion

# TODO 游戏暂停页面 ===============>变 量<===============
#region 变量
# 游戏暂停页面：继续游戏按钮的容器
@onready var continue_game_button: GameButton = %ContinueGameButton
# 游戏暂停页面：返回主菜单游戏按钮的容器
@onready var exit_game_button: GameButton = %ExitGameButton
# 游戏暂停页面：机关图鉴游戏按钮的容器
@onready var codex_game_button: GameButton = %CodexGameButton
# 游戏暂停界面：剧情图鉴游戏按钮容器
@onready var plot_game_button: GameButton = %PlotGameButton
# 游戏暂停页面：游戏设置按钮的容器
@onready var setting_game_button: GameButton = %SettingGameButton
# 游戏图鉴界面
@onready var organ_codex_panel_container: OrganCodexPanelContainer = %OrganCodexPanelContainer
# 游戏剧情图鉴界面
@onready var plot_panel: PlotPanel = $"../PlotPanel"
# 游戏设置界面
@onready var setting_panel_container: SettingPanelContainer = %SettingPanelContainer
# 游戏暂停界面：初始位置
var current_pos : Vector2
#endregion

# TODO 游戏暂停页面 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	#  链接按钮上的 pressed 信号
	continue_game_button.pressed.connect(_on_continue_game_button_pressed)
	exit_game_button.pressed.connect(_on_exit_game_button_pressed)
	codex_game_button.pressed.connect(_on_codex_game_button_pressed)
	plot_game_button.pressed.connect(_on_plot_game_button_pressed)
	setting_game_button.pressed.connect(_on_setting_game_button_pressed)

	if not current_pos:
		current_pos = global_position


func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("action_esc"):
			UiTool.hide_all_ui(get_parent(), self)
			visible = true

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 游戏暂停页面 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 游戏暂停页面：继续游戏按钮：pressed 信号方法
func _on_continue_game_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()

# TODO_FUC 游戏暂停页面：返回主菜单按钮：pressed 信号方法
func _on_exit_game_button_pressed() -> void:
	LoadAndSave.save_game()

	GlobalValue.reset_buff()
	GlobalValue.reset()
	GlobalValue.skill_point = 0

	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 返回主菜单
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.MAIN, Global.shader_index)

# TODO_FUC 游戏暂停页面：visible 切换的信号方法
func _on_visibility_changed() -> void:
	if visible:
		self.global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

# TODO_FUC 游戏暂停页面：机关图鉴按钮 pressed 信号方法
func _on_codex_game_button_pressed() -> void:
	organ_codex_panel_container.show()

func _on_plot_game_button_pressed() -> void:
	plot_panel.show()

# TODO_FUC 游戏暂停页面：游戏设置按钮 pressed 信号方法
func _on_setting_game_button_pressed() -> void:
	setting_panel_container.show()
#endregion

# TODO 游戏暂停页面 ===============>工具方法<===============
#region 工具方法
## TODO_FUC 游戏暂停页面：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()
#endregion
