#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name CDPanelContainer extends PanelContainer

# TODO CD机页面 ===============>信 号<===============
#region 信号
#endregion

# TODO CD机页面 ===============>常 量<===============
#region 常量

#endregion

# TODO CD机页面 ===============>变 量<===============
#region 变量
# CD机页面：继续游戏按钮
@onready var return_button: Button = $SlotPanelContainer/MarginContainer/HBoxContainer/Row3/Control/Return
# CD机页面：重置按钮
@onready var reset_cd: Button = $SlotPanelContainer/MarginContainer/HBoxContainer/Row1/HBoxContainer/VBoxContainer/ResetCD
# CD机页面：确认按钮
@onready var decide_cd: Button = $SlotPanelContainer/MarginContainer/HBoxContainer/Row1/HBoxContainer/DecideCD
# CD机页面：CD1按钮
@onready var cdslot_1: Button = $SlotPanelContainer/MarginContainer/HBoxContainer/Row1/CDslot_1
# CD机页面：CD2按钮
@onready var cdslot_2: Button = $SlotPanelContainer/MarginContainer/HBoxContainer/Row2/CDslot_2
# CD机页面：CD3按钮
@onready var cdslot_3: Button = $SlotPanelContainer/MarginContainer/HBoxContainer/Row2/CDslot_3
# CD机页面：CD4按钮
@onready var cdslot_4: Button = $SlotPanelContainer/MarginContainer/HBoxContainer/Row3/CDslot_4
# CD机页面：CD选择页面
@onready var cd_container: PanelContainer = $CDContainer
# CD机界面：CD列表
@onready var cd_group: VBoxContainer = %CDGroup
# CD机页面：CD选择页面可视
var cd_container_visibility : bool = false
# 这个UI加载完毕后的位置
var current_pos : Vector2
# UI大小
var panel_size : Vector2
# 选择的CD的index
var cd_index : int = -1
# 当前的CD位置
var cd_slot_index : int
#endregion

# TODO CD机页面 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	#  链接按钮上的 pressed 信号
	return_button.pressed.connect(return_button_pressed)
	reset_cd.pressed.connect(reset_cd_pressed)
	decide_cd.pressed.connect(decide_cd_pressed)
	cdslot_1.pressed.connect(cdslot_1_pressed)
	cdslot_2.pressed.connect(cdslot_2_pressed)
	cdslot_3.pressed.connect(cdslot_3_pressed)
	cdslot_4.pressed.connect(cdslot_4_pressed)
	visibility_changed.connect(_on_cd_panel_container_visibility_changed)

	if not current_pos:
		current_pos = global_position

	for i in AudioManager.cd.size():
		if AudioManager.cd[i] == null: continue
		match i:
			0:
				cdslot_1.icon = AudioManager.cd[i].cd_texture
			1:
				cdslot_2.icon = AudioManager.cd[i].cd_texture
			2:
				cdslot_3.icon = AudioManager.cd[i].cd_texture
			3:
				cdslot_4.icon = AudioManager.cd[i].cd_texture

func _process(_delta: float) -> void:
	if cd_index == -1:
		decide_cd.disabled = true
	else :
		decide_cd.disabled = false

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("action_cd") and (Global.player.in_the_crystal or Global.player.can_heal_light) and not Global.is_command:
			UiTool.hide_all_ui(get_parent(), self)
			visible = true

func _exit_tree() -> void:
	# 断开按钮上的 pressed 信号
	return_button.pressed.disconnect(return_button_pressed)
#endregion

# TODO CD机页面 ===============>信号链接方法<===============
#region 信号链接方法
# TODO CD机页面：继续游戏按钮：pressed 信号方法
func return_button_pressed() -> void:
	if not cd_container.position.x == 0:
		var tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
		tween.tween_property(cd_container, "position:x", 0, .5)
		tween.tween_property(self, "global_position:x", current_pos.x, .5)
		tween.tween_property(cd_container, "modulate:a", 0, .5)
		await tween.finished

	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭CD机页面
	hide()

## TODO_FUNC CD机页面：重置按钮：pressed 信号方法
func reset_cd_pressed() -> void:
	for index in AudioManager.cd.size():
		if AudioManager.cd[index] == null: continue
		AudioManager.has_cd.append(AudioManager.cd[index])
		AudioManager.cd[index] = null

	cdslot_1.icon = null
	cdslot_2.icon = null
	cdslot_3.icon = null
	cdslot_4.icon = null

	AudioManager.bgm_play()
	GlobalValue.reset_buff()

## TODO_FUNC CD机页面：确认按钮：pressed 信号方法
func decide_cd_pressed() -> void:
	if AudioManager.cd[cd_slot_index]:
		AudioManager.has_cd.append(AudioManager.cd[cd_slot_index])
		AudioManager.cd[cd_slot_index] = AudioManager.has_cd.pop_at(cd_index)
	else :
		AudioManager.cd[cd_slot_index] = AudioManager.has_cd.pop_at(cd_index)

	match cd_slot_index:
		0:
			cdslot_1.icon = AudioManager.cd[cd_slot_index].cd_texture
		1:
			cdslot_2.icon = AudioManager.cd[cd_slot_index].cd_texture
		2:
			cdslot_3.icon = AudioManager.cd[cd_slot_index].cd_texture
		3:
			cdslot_4.icon = AudioManager.cd[cd_slot_index].cd_texture

	var tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(cd_container, "position:x", 0, .5)
	tween.tween_property(self, "global_position:x", current_pos.x, .5)
	tween.tween_property(cd_container, "modulate:a", 0, .5)

	AudioManager.bgm_play()

	cd_index = -1

## TODO_FUNC CD机页面：CD槽位按钮：pressed 信号方法
func cdslot_1_pressed() -> void:
	cd_slot_index = 0
	create_cd_list()
	show_cd_container()

## TODO_FUNC CD机页面：CD槽位按钮：pressed 信号方法
func cdslot_2_pressed() -> void:
	cd_slot_index = 1
	create_cd_list()
	show_cd_container()

## TODO_FUNC CD机页面：CD槽位按钮：pressed 信号方法
func cdslot_3_pressed() -> void:
	cd_slot_index = 2
	create_cd_list()
	show_cd_container()

## TODO_FUNC CD机页面：CD槽位按钮：pressed 信号方法
func cdslot_4_pressed() -> void:
	cd_slot_index = 3
	create_cd_list()
	show_cd_container()

## TODO_FUC CD机页面：UI显示切换信号方法
func _on_cd_panel_container_visibility_changed() -> void:
	if visible:
		global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

# TODO_FUC CD机页面：CDPanel 的chick 信号方法
func _on_cd_panel_chick(index : int) -> void:
	for i in cd_group.get_child_count():
		if i == index: continue
		cd_group.get_children()[i].selected = false

	cd_index = index
#endregion

# TODO CD机页面 ===============>工具方法<===============
#region 工具方法
## TODO_FUC CD机页面：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()

# TODO_FUC CD机页面：CD列表显示
func show_cd_container() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(cd_container, "position:x", -220, .5)
	tween.tween_property(self, "global_position:x", current_pos.x + 100, .5)
	tween.tween_property(cd_container, "modulate:a", 1, .5)

# TODO_FUC CD机页面：CD UI 创建
func create_cd_list() -> void:
	for i in cd_group.get_children():
		i.queue_free()

	for i in AudioManager.has_cd:
		var cd_panel : CDPanel = UiTool.CD_PANEL.instantiate()
		cd_panel.text = i.cd_name
		if i.cd_texture:
			cd_panel.texture = i.cd_texture
		cd_panel.chick_cd_panel.connect(_on_cd_panel_chick)
		cd_group.add_child(cd_panel)

#endregion
