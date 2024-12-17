#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name SettingPanelContainer extends PanelContainer

# TODO 设置界面 UI ===============>信 号<===============
#region 信号

#endregion

# TODO 设置界面 UI ===============>常 量<===============
#region 常量

#endregion

# TODO 设置界面 UI ===============>变 量<===============
#region 变量
@onready var close_game_button: GameButton = $MarginContainer/CloseGameButton
@onready var general_game_button: GameButton = %GeneralGameButton
@onready var audio_game_button: GameButton = %AudioGameButton
@onready var general_container: VBoxContainer = %GeneralContainer
@onready var audio_container: VBoxContainer = %AudioContainer

# 设置界面 UI:音量设置容器
@onready var main_volume: VolumeSLot = %MainVolume
@onready var bgm_volume: VolumeSLot = %BGMVolume
@onready var sfx_volume: VolumeSLot = %SFXVolume
@onready var environment_volume: VolumeSLot = %EnvironmentVolume

# 设置界面 UI：全局设置
@onready var screen_mode_check_button: CheckButton = %ScreenModeCheckButton
@onready var camera_mode_check_button: CheckButton = %CameraModeCheckButton
@onready var key_tip_check_button: CheckButton = %KeyTipCheckButton
@onready var glow_check_button: CheckButton = %GlowCheckButton

var current_pos : Vector2
#endregion

# TODO 设置界面 UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	general_game_button.pressed.connect(_on_general_game_button_pressed)
	audio_game_button.pressed.connect(_on_audio_game_button_pressed)
	close_game_button.pressed.connect(_on_close_game_button_pressed)

	screen_mode_check_button.toggled.connect(_on_screen_mode_check_button_toggled)
	camera_mode_check_button.toggled.connect(_on_camera_mode_check_button_toggled)
	key_tip_check_button.toggled.connect(_on_key_tip_check_button_toggled)
	glow_check_button.toggled.connect(_on_glow_check_button_toggled)

	if not current_pos:
		current_pos = global_position

	if LoadAndSave.has_config():
		LoadAndSave.load_config()
		screen_mode_check_button.button_pressed = Global.full_screen_enabled
		camera_mode_check_button.button_pressed = Global.camera_mode_enabled
		key_tip_check_button.button_pressed = Global.key_tip_enabled
		glow_check_button.button_pressed = Global.glow_enabled

		main_volume.h_slider.value = Global.main_volume
		bgm_volume.h_slider.value = Global.bgm_volume
		sfx_volume.h_slider.value = Global.sfx_volume
		environment_volume.h_slider.value = Global.ambient_volume

		main_volume.check_box.button_pressed = Global.is_main_volume
		bgm_volume.check_box.button_pressed = Global.is_bgm_volume
		sfx_volume.check_box.button_pressed = Global.is_sfx_volume
		environment_volume.check_box.button_pressed = Global.is_ambient_volume

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 设置界面 UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 设置界面 UI：关闭按钮： pressed 信号方法
func _on_close_game_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)

	Global.main_volume = main_volume.h_slider.value
	Global.bgm_volume = bgm_volume.h_slider.value
	Global.sfx_volume = sfx_volume.h_slider.value
	Global.ambient_volume = environment_volume.h_slider.value

	Global.full_screen_enabled = screen_mode_check_button.button_pressed
	Global.camera_mode_enabled = camera_mode_check_button.button_pressed
	Global.key_tip_enabled = key_tip_check_button.button_pressed
	Global.glow_enabled = glow_check_button.button_pressed

	Global.is_main_volume = main_volume.check_box.button_pressed
	Global.is_bgm_volume = bgm_volume.check_box.button_pressed
	Global.is_sfx_volume = sfx_volume.check_box.button_pressed
	Global.is_ambient_volume = environment_volume.check_box.button_pressed

	LoadAndSave.save_config()

	# 关闭机关图鉴页面
	hide()

# TODO_FUC 设置界面 UI：常规设置按钮： pressed 信号方法
func _on_general_game_button_pressed() -> void:
	audio_container.hide()
	general_container.show()

# TODO_FUC 设置界面 UI：音频设置按钮： pressed 信号方法
func _on_audio_game_button_pressed() -> void:
	general_container.hide()
	audio_container.show()

# TODO_FUC 机关图鉴：关闭按钮： 切换显示信号方法
func _on_visibility_changed() -> void:
	if visible:
		UiTool.hide_all_ui(get_parent(), self)
		global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

# TODO_FUC
func _on_screen_mode_check_button_toggled(toggled : bool) -> void:
	Global.full_screen_enabled = toggled
	if toggled:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# TODO_FUC
func _on_camera_mode_check_button_toggled(toggled : bool) -> void:
	Global.camera_mode_enabled = toggled

# TODO_FUC
func _on_key_tip_check_button_toggled(toggled : bool) -> void:
	Global.key_tip_enabled = toggled

# TODO_FUC
func _on_glow_check_button_toggled(toggled : bool) -> void:
	Global.glow_enabled = toggled

#endregion

# TODO 设置界面 UI ===============>工具方法<===============
#region 工具方法
## TODO_FUC 设置界面 UI：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()
#endregion
