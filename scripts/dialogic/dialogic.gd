#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends CanvasLayer

# TODO 对话模块 ===============>信 号<===============
#region 信号
signal dialogic_is_ending
#endregion

# TODO 对话模块 ===============>常 量<===============
#region 常量

#endregion

# TODO 对话模块 ===============>变 量<===============
#region 变量
# 对话模块：面板容器
@onready var panel_container: PanelContainer = $PanelContainer
# 对话模块：文本容器
@onready var context_label: Label = $PanelContainer/MarginContainer/ContextLabel
# 对话模块：当前段落
var current_paragraph : DialogicParagraph
# 对话模块：当前内容
var current_context : DialogicContext
# 对话模块：当前内容索引
var current_context_index : int = 0
# 对话模块：当前位置
var current_pos : Vector2
# 对话模块：是否播放
var dialogic_is_playing : bool = false
#endregion

# TODO 对话模块 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	if not current_pos:
		current_pos = panel_container.global_position

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 对话模块 ===============>信号链接方法<===============
#region 信号链接方法
func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_left"):
			next_dialogic_context()
#endregion

# TODO 对话模块 ===============>工具方法<===============
#region 工具方法
# 对话模块：播放对话内容
func play_dialogic_context(paragraph : DialogicParagraph, context_index : int = 0) -> void:
	dialogic_is_playing = true
	UiTool.hide_all_ui(get_parent(), self)
	show()
	panel_container.global_position.y = current_pos.y - 1000
	await UiTool.ui_enter(panel_container, current_pos)

	current_paragraph = paragraph
	current_context_index = 0
	current_context = current_paragraph.contexts[context_index]
	context_label.text = current_context.sentences[current_context_index]

func next_dialogic_context() -> void:
	current_context_index += 1

	if current_context.sentences.size() <= current_context_index:
		exit_dialogic()
		return

	context_label.text = current_context.sentences[current_context_index]

	print(context_label.text)

func exit_dialogic() -> void:
	dialogic_is_playing = false
	context_label.text = ""
	current_context_index = 0
	await UiTool.ui_exit(panel_container)
	hide()
	dialogic_is_ending.emit()
#endregion
