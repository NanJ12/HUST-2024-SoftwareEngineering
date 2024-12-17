#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name TransferPanelContainer extends PanelContainer

# TODO 传送页面 ===============>信 号<===============
#region 信号
#endregion

# TODO 传送页面 ===============>常 量<===============
#region 常量

#endregion

# TODO 传送页面 ===============>变 量<===============
#region 变量
# 传送页面：继续游戏按钮
@onready var return_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Return
# 传送页面：确认按钮
@onready var decide_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Decide
# 传送页面：水晶按钮
@onready var tran_points_group_container: VBoxContainer = $MarginContainer/HBoxContainer/MapPanelContainer/ScrollContainer/TranPointsGroupContainer
# 这个UI加载完毕后的位置
var current_pos : Vector2
# 传送页面：传送点坐标
var transfer_pos : Vector2 = Vector2(-1, -1)
#endregion

# TODO 传送页面 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	#  链接按钮上的 pressed 信号
	return_button.pressed.connect(return_button_pressed)
	decide_button.pressed.connect(decide_button_pressed)
	self.visibility_changed.connect(_on_visibility_changed)

	if not current_pos:
		current_pos = global_position

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if transfer_pos == Vector2(-1, -1): decide_button.disabled = true
	else : decide_button.disabled = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("action_transfer") and (Global.player.in_the_crystal or Global.player.can_heal_light) and not Global.is_command:
			UiTool.hide_all_ui(get_parent(), self)
			visible = true

func _unhandled_input(_event: InputEvent) -> void:
	pass

func _exit_tree() -> void:
	# 断开按钮上的 pressed 信号
	return_button.pressed.disconnect(return_button_pressed)
#endregion

# TODO 传送页面 ===============>信号链接方法<===============
#region 信号链接方法
# TODO 传送页面：继续游戏按钮：pressed 信号方法
func return_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭传送页面
	hide()

## TODO_FUNC 传送页面：确认按钮：pressed 信号方法
func decide_button_pressed() -> void:
	if transfer_pos != Vector2(-1, -1):
		await GroundGlass.glass_exit()
		await UiTool.ui_exit(self)
		# 关闭传送页面
		hide()

		# 使用 Tween 实现将玩家传送回存档点
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK).set_parallel()
		tween.tween_property(Global.player, "scale", Vector2.ZERO, 0.75)
		tween.chain().tween_property(Global.player, "global_position", transfer_pos, 0.75)
		tween.chain().tween_property(Global.player, "scale", Vector2.ONE, 0.75)
		await tween.finished
		transfer_pos = Vector2(-1, -1)

## TODO_FUC 传送页面：UI显示切换信号方法
func _on_visibility_changed() -> void:
	if visible:
		show_spawn_point_list()
		global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

# TODO_FUC 传送页面：获取传送点
func _on_tran_point_selected_panel(pos : Vector2, index : int) -> void:
	transfer_pos = pos
	for i in tran_points_group_container.get_child_count():
		if i == index: continue
		tran_points_group_container.get_children()[i].selected = false
#endregion

# TODO 传送页面 ===============>工具方法<===============
#region 工具方法
## TODO_FUC 传送页面：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()

# TODO_FUC 传送页面：显示传送点列表
func show_spawn_point_list() -> void:
	for i in tran_points_group_container.get_children():
		i.queue_free()

	for i in Global.spawn_points:
		var tran_point : TranPointPanelContainer = UiTool.TRAN_POINT_PANEL_CONTAINER.instantiate()
		tran_point.text = i
		tran_point.pos = Global.spawn_points[i]
		tran_points_group_container.add_child(tran_point)
		tran_point.selected_panel.connect(_on_tran_point_selected_panel)
#endregion
