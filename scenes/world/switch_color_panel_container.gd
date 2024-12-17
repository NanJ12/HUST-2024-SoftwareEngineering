#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name SwitchColorPanelContainer extends PanelContainer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var player_color_slot_1: GameButton = %PlayerColorSlot1
@onready var player_color_slot_2: GameButton = %PlayerColorSlot2
@onready var player_color_slot_3: GameButton = %PlayerColorSlot3
@onready var player_color_grid_container: GridContainer = %PlayerColorGridContainer
@onready var decide_game_button: GameButton = %DecideGameButton
@onready var back_game_button: GameButton = %BackGameButton
@onready var player_color_slot_container: HBoxContainer = %PlayerColorSlotContainer

# 玩家颜色切换界面：初始位置
var current_pos : Vector2

var selected_color_slot_index : int = -1
var selected_color_index : int = -1
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	player_color_slot_1.pressed.connect(_on_player_color_slot_1_pressed)
	player_color_slot_2.pressed.connect(_on_player_color_slot_2_pressed)
	player_color_slot_3.pressed.connect(_on_player_color_slot_3_pressed)
	decide_game_button.pressed.connect(_on_decide_game_button_pressed)
	back_game_button.pressed.connect(_on_back_game_button_pressed)

	if not current_pos:
		current_pos = global_position

	create_color_list()

func _process(_delta: float) -> void:
	if selected_color_slot_index == -1 or selected_color_index == -1:
		decide_game_button.disabled = true
	else :
		decide_game_button.disabled = false

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("action_switch_color") and not Global.is_command:
			UiTool.hide_all_ui(get_parent(), self)
			visible = true
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 颜色切换界面：界面显示切换信号方法
func _on_visibility_changed() -> void:
	if visible:
		self.global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

# TODO_FUC 颜色切换界面：颜色1按钮Pressed信号方法
func _on_player_color_slot_1_pressed() -> void:
	selected_color_slot_index = 0
	create_color_list()

# TODO_FUC 颜色切换界面：颜色2按钮Pressed信号方法
func _on_player_color_slot_2_pressed() -> void:
	selected_color_slot_index = 1
	create_color_list()

# TODO_FUC 颜色切换界面：颜色3按钮Pressed信号方法
func _on_player_color_slot_3_pressed() -> void:
	selected_color_slot_index = 2
	create_color_list()

# TODO_FUC 颜色切换界面：确定按钮Pressed信号方法
func _on_decide_game_button_pressed() -> void:
	if Global.player_colors[selected_color_slot_index] == null:
		Global.player_colors[selected_color_slot_index] = Global.has_player_colors.pop_at(selected_color_index)
	else :
		Global.has_player_colors.append(Global.player_colors[selected_color_slot_index])
		Global.player_colors[selected_color_slot_index] = Global.has_player_colors.pop_at(selected_color_index)
	create_color_list()

	selected_color_slot_index = -1
	selected_color_index = -1

# TODO_FUC 颜色切换界面：返回按钮Pressed信号方法
func _on_back_game_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭技能树窗口
	hide()

func _on_player_color_panel_chick(index : int) -> void:
	selected_color_index = index
	for i in player_color_grid_container.get_child_count():
		if i == index: continue
		player_color_grid_container.get_children()[i].selected = false
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
## TODO_FUC 颜色切换界面：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()

# TODO_FUC 颜色切换界面：ColorList 创建
func create_color_list() -> void:
	for i in player_color_grid_container.get_children():
		i.queue_free()

	for i in Global.has_player_colors:
		var color_panel : PlayerColorPanel = UiTool.PLAYER_COLOR_PANEL.instantiate()
		if i.player_color_texture:
			color_panel.texture = i.player_color_texture
		color_panel.chick_player_color_panel.connect(_on_player_color_panel_chick)
		player_color_grid_container.add_child(color_panel)

	for i in player_color_slot_container.get_child_count():
		if Global.player_colors[i] != null:
			player_color_slot_container.get_child(i).icon = Global.player_colors[i].player_color_texture
#endregion
