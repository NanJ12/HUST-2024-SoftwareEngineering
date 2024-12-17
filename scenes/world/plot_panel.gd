#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name PlotPanel extends PanelContainer

# TODO 剧情图鉴页面 ===============>信 号<===============
#region 信号

#endregion

# TODO 剧情图鉴页面 ===============>常 量<===============
#region 常量

#endregion

# TODO 剧情图鉴页面 ===============>变 量<===============
# 剧情图鉴页面：返回
@onready var return_button: Button = $MarginContainer/HBoxContainer/HBoxContainer/ReturnButton
# 剧情图鉴页面：初始位置
var current_pos : Vector2

@onready var memory_fragment_grid_container: GridContainer = %MemoryFragmentGridContainer
@onready var memory_fragment_panel_container: PanelContainer = $MemoryFragmentPanelContainer
@onready var texture_rect: TextureRect = $MemoryFragmentPanelContainer/MarginContainer/HBoxContainer/TextureRect
@onready var name_label: Label = $MemoryFragmentPanelContainer/MarginContainer/HBoxContainer/ScrollContainer/VBoxContainer/NameLabel
@onready var desc_label: Label = $MemoryFragmentPanelContainer/MarginContainer/HBoxContainer/ScrollContainer/VBoxContainer/DescLabel
@onready var close_panel_game_button: GameButton = $MemoryFragmentPanelContainer/MarginContainer/ClosePanelGameButton
#endregion

# TODO 剧情图鉴页面 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	#  链接按钮上的 pressed 信号
	return_button.pressed.connect(_on_return_button_pressed)
	self.visibility_changed.connect(_on_visibility_changed)
	close_panel_game_button.pressed.connect(_on_close_panel_game_button_pressed)
	if not current_pos:
		current_pos = global_position

	create_memory_fragment_list()




func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 剧情图鉴页面 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 剧情图鉴页面：继续游戏按钮：pressed 信号方法
func _on_return_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭BUFF页面
	hide()

# TODO_FUC 剧情图鉴页面：按钮：pressed 信号方法


# TODO_FUC 剧情图鉴页面：visible 切换的信号方法
func _on_visibility_changed() -> void:
	if visible:
		UiTool.hide_all_ui(get_parent(), self)
		self.global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)
		create_memory_fragment_list()

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

func _on_memory_fragment_click(index : int) -> void:
	texture_rect.texture = Global.memory_fragments[index].memory_fragment_texture
	name_label.text = Global.memory_fragments[index].memory_fragment_name
	desc_label.text = Global.memory_fragments[index].memory_fragment_context
	memory_fragment_panel_container.show()
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(memory_fragment_panel_container, "modulate:a", 1, .75)

func _on_close_panel_game_button_pressed() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(memory_fragment_panel_container, "modulate:a", 0, .75)
	await tween.finished
	memory_fragment_panel_container.show()
#endregion

# TODO 剧情图鉴页面 ===============>工具方法<===============
#region 工具方法
# TODO_FUC
func create_memory_fragment_list() -> void:
	for i in memory_fragment_grid_container.get_children():
		i.queue_free()

	for i in Global.memory_fragments:
		var memory_fragment_panel : MemoryFragmentsPanelContainer = UiTool.MEMORY_FRAGMENTS_PANEL_CONTAINER.instantiate()
		memory_fragment_panel.set_memory_fragment_panel(i.memory_fragment_name, i.memory_fragment_texture)
		memory_fragment_panel.click_memory_fragment.connect(_on_memory_fragment_click)
		memory_fragment_grid_container.add_child(memory_fragment_panel)

## TODO_FUC BUFF页面：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭剧情图鉴页面
	hide()
#endregion
