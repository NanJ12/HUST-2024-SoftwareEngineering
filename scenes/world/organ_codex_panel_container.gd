#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name OrganCodexPanelContainer extends PanelContainer

# TODO 机关图鉴 UI ===============>信 号<===============
#region 信号

#endregion

# TODO 机关图鉴 UI ===============>常 量<===============
#region 常量

#endregion

# TODO 机关图鉴 UI ===============>变 量<===============
#region 变量
@export var continuous_organs : Array[PackedScene]
@export var trigger_organs : Array[PackedScene]
@export var intermittent_organs : Array[PackedScene]

@onready var tab_container: TabContainer = $MarginContainer/VBoxContainer/HBoxContainer/TabContainer
@onready var close_game_button: GameButton = $MarginContainer/CloseGameButton

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/ContextPanelContainer/VBoxContainer/TextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/ContextPanelContainer/VBoxContainer/NameLabel
@onready var desc_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/ContextPanelContainer/VBoxContainer/DescLabel

@onready var continuous_panel_container: MarginContainer = %ContinuousPanelContainer
@onready var trigger_panel_container: MarginContainer = %TriggerPanelContainer
@onready var intermittent_panel_container: MarginContainer = %IntermittentPanelContainer

var current_pos : Vector2

var selected_organ_slot_index : int
var organ_type_index : int
#endregion

# TODO 机关图鉴 UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	close_game_button.pressed.connect(_on_close_game_button_pressed)

	if not current_pos:
		current_pos = global_position

	tab_container.set_tab_title(0, "持续型")
	tab_container.set_tab_title(1, "触发型")
	tab_container.set_tab_title(2, "间断型")

	tab_container.set_tab_icon_max_width(0, 128)
	tab_container.set_tab_icon_max_width(1, 128)
	tab_container.set_tab_icon_max_width(2, 128)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 机关图鉴 UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关图鉴：关闭按钮： pressed 信号方法
func _on_close_game_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭机关图鉴页面
	hide()

# TODO_FUC 机关图鉴：关闭按钮： 切换显示信号方法
func _on_visibility_changed() -> void:
	if visible:
		UiTool.hide_all_ui(get_parent(), self)
		global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

func _on_continuous_panel_container_visibility_changed() -> void:
	if visible:
		for i in continuous_panel_container.get_child(0).get_children():
			i.queue_free()

		for i in continuous_organs:
			var organ : Organ = i.instantiate()
			var organ_panel : OrganPanelContainer = UiTool.ORGAN_PANEL_CONTAINER.instantiate()
			organ_panel.chick_organ_slot.connect(_on_organ_panel_click_organ_slot)
			organ_panel.set_organ_panel(organ.organ_name, organ.organ_texture)
			continuous_panel_container.get_child(0).add_child(organ_panel)

func _on_trigger_panel_container_visibility_changed() -> void:
	if visible:
		for i in trigger_panel_container.get_child(0).get_children():
			i.queue_free()

		for i in trigger_organs:
			var organ : Organ = i.instantiate()
			var organ_panel : OrganPanelContainer = UiTool.ORGAN_PANEL_CONTAINER.instantiate()
			organ_panel.chick_organ_slot.connect(_on_organ_panel_click_organ_slot)
			organ_panel.set_organ_panel(organ.organ_name, organ.organ_texture)
			trigger_panel_container.get_child(0).add_child(organ_panel)


func _on_intermittent_panel_container_visibility_changed() -> void:
	if visible:
		for i in intermittent_panel_container.get_child(0).get_children():
			i.queue_free()

		for i in intermittent_organs:
			var organ : Organ = i.instantiate()
			var organ_panel : OrganPanelContainer = UiTool.ORGAN_PANEL_CONTAINER.instantiate()
			organ_panel.chick_organ_slot.connect(_on_organ_panel_click_organ_slot)
			organ_panel.set_organ_panel(organ.organ_name, organ.organ_texture)
			intermittent_panel_container.get_child(0).add_child(organ_panel)
			organ.queue_free()

func _on_organ_panel_click_organ_slot(index : int) -> void:
	selected_organ_slot_index = index

	match tab_container.current_tab:
		0:
			var organ : Organ = continuous_organs[selected_organ_slot_index].instantiate()
			texture_rect.texture = organ.organ_texture
			name_label.text = organ.organ_name
			desc_label.text = organ.organ_desc
			organ.queue_free()
		1:
			var organ : Organ = trigger_organs[selected_organ_slot_index].instantiate()
			texture_rect.texture = organ.organ_texture
			name_label.text = organ.organ_name
			desc_label.text = organ.organ_desc
			organ.queue_free()
		2:
			var organ : Organ = intermittent_organs[selected_organ_slot_index].instantiate()
			texture_rect.texture = organ.organ_texture
			name_label.text = organ.organ_name
			desc_label.text = organ.organ_desc
			organ.queue_free()

#endregion

# TODO 机关图鉴 UI ===============>工具方法<===============
#region 工具方法
## TODO_FUC 机关图鉴：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()
#endregion
