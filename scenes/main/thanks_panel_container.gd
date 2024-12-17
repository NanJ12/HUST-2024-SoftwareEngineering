#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name ThanksPanelContainer extends PanelContainer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var scroll_label_container: ScrollContainer = $MarginContainer/VBoxContainer/ScrollLabelContainer
var current_pos : Vector2
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	scroll_label_container.scroll_vertical = 0

	if not current_pos:
		current_pos = global_position

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_close_game_button_pressed() -> void:
	if SceneManager.current_scene_index == 0:
		await GroundGlass.glass_exit()
		await UiTool.ui_exit(self)

		hide()
	elif SceneManager.current_scene_index == 1:
		await GroundGlass.glass_exit()
		await UiTool.ui_exit(self)

		SceneManager.scene_switch(SceneManager.SCENE_INDEX.MAIN, Global.shader_index)

		hide()

func _on_visibility_changed() -> void:
	if visible:
		scroll_label_container.scroll_vertical = 0

		UiTool.hide_all_ui(get_parent(), self)
		global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

		var tween : Tween = create_tween()
		tween.tween_property(scroll_label_container, "scroll_vertical", 1624, 45.)
		await tween.finished

		await GroundGlass.glass_exit()
		await UiTool.ui_exit(self)

		if SceneManager.current_scene_index == 1:
			SceneManager.scene_switch(SceneManager.SCENE_INDEX.MAIN, Global.shader_index)
		hide()
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
## TODO_FUC 设置界面 UI：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()
#endregion
