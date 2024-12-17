#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name BuffsPanel extends PanelContainer

# TODO BUFF页面 ===============>信 号<===============
#region 信号

#endregion

# TODO BUFF页面 ===============>常 量<===============
#region 常量

#endregion

# TODO BUFF页面 ===============>变 量<===============
@onready var return_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/Return
@onready var buff_group: GridContainer = %BuffGroup

# 游戏暂停界面：初始位置
var current_pos : Vector2
#endregion

# TODO BUFF页面 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	self.visibility_changed.connect(_on_visibility_changed)
	if not current_pos:
		current_pos = global_position


func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("action_buff") and not Global.is_command:
			UiTool.hide_all_ui(get_parent(), self)
			visible = true

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO BUFF页面 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 游戏暂停页面：继续游戏按钮：pressed 信号方法
func _on_return_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭BUFF页面
	hide()

# TODO_FUC BUFF页面：BUFF按钮：pressed 信号方法
func _on_buff_1_pressed() -> void:
	pass

func _on_buff_2_pressed() -> void:
	pass

func _on_buff_3_pressed() -> void:
	pass

func _on_buff_4_pressed() -> void:
	pass

# TODO_FUC BUFF页面：visible 切换的信号方法
func _on_visibility_changed() -> void:
	if visible:
		self.global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

		for i in buff_group.get_children():
			i.queue_free()

		for i in Global.player.buffs:
			var buff_panel : BuffPanelContainer = UiTool.BUFF_PANEL_CONTAINER.instantiate()
			buff_panel.set_buff_panel(i.buff_texture)
			buff_group.add_child(buff_panel)

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

#endregion

# TODO BUFF页面 ===============>工具方法<===============
#region 工具方法
## TODO_FUC BUFF页面：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭BUFF页面
	hide()
#endregion
