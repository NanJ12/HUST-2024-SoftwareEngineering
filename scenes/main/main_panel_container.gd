#--------------------------------------
# 这个类是主菜单的 UI 管理类。
# 类中链接了主菜单的按钮的各种信号
#
#--------------------------------------
class_name MainPanelContainer extends PanelContainer

# TODO 游戏主页面 ===============>信 号<===============
#region 信号
# 获得开始按钮
@onready var start_game_button: GameButton = %StartGameButton
# 获得退出按钮
@onready var exit_game_button: GameButton = %ExitGameButton
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
# 获得继续按钮
@onready var continue_game_button: GameButton = %ContinueGameButton
# 获得设置按钮
@onready var setting_game_button: GameButton = %SettingGameButton
# 获得感谢按钮
@onready var thanks_game_button: GameButton = %ThanksGameButton

@onready var thanks_panel_container: ThanksPanelContainer = $"../../UI_EX/ThanksPanelContainer"
@onready var setting_panel_container: SettingPanelContainer = $"../../UI_EX/SettingPanelContainer"
#endregion

# TODO 游戏主页面 ===============>常 量<===============
#region 常量

#endregion

# TODO 游戏主页面 ===============>变 量<===============
#region 变量
# 游戏主页面：初始位置
var current_pos : Vector2
#endregion

# TODO 游戏主页面 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	current_pos = global_position

	texture_rect.pivot_offset = texture_rect.size / 2

	# 链接按钮上的 pressed 信号
	start_game_button.pressed.connect(_on_start_game_button_pressed)
	exit_game_button.pressed.connect(_on_exit_game_button_pressed)
	continue_game_button.pressed.connect(_on_continue_game_button_pressed)
	setting_game_button.pressed.connect(_on_setting_game_button_pressed)
	thanks_game_button.pressed.connect(_on_thanks_game_button_pressed)

	if LoadAndSave.has_save():
		continue_game_button.disabled = false
	else :
		continue_game_button.disabled = true

	get_child(0).global_position.y = current_pos.y - 1000
	await UiTool.ui_enter(self.get_child(0), current_pos)


func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass

func _exit_tree() -> void:
	pass
#endregion

# TODO 游戏主页面 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 游戏主页面：开始游戏按钮：pressed 信号方法
func _on_start_game_button_pressed() -> void:
	Global.is_load_save = false
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self.get_child(0), "global_position:y", -1500, .75)
	await tween.finished
	# 进入游戏场景
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.WORLD, Global.shader_index)

func _on_continue_game_button_pressed() -> void:
	Global.is_load_save = true
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self.get_child(0), "global_position:y", -1500, .75)
	await tween.finished
	# 进入游戏场景
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.WORLD, Global.shader_index)

# TODO_FUC 游戏主页面：退出游戏按钮：pressed 信号方法
func _on_exit_game_button_pressed() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self.get_child(0), "global_position:y", -1500, .75)
	await tween.finished
	# 退出游戏
	get_tree().quit()

func _on_texture_rect_mouse_entered() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(texture_rect, "scale", Vector2.ONE * 1.2, .75)


func _on_texture_rect_mouse_exited() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(texture_rect, "scale", Vector2.ONE, .75)

func _on_setting_game_button_pressed() -> void:
	setting_panel_container.show()

func _on_thanks_game_button_pressed() -> void:
	thanks_panel_container.show()
#endregion

# TODO 游戏主页面 ===============>工具方法<===============
#region 工具方法

#endregion
