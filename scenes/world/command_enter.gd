#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name CommandEnter extends HBoxContainer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
# 游戏暂停界面：初始位置
@onready var line_edit: LineEdit = $LineEdit
var current_pos : Vector2
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	# 游戏按钮：修改聚焦模式为无
	focus_mode = FocusMode.FOCUS_NONE

	if not current_pos:
		current_pos = global_position

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("action_command"):
			if visible:
				var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
				tween.tween_property(self, "global_position:y", current_pos.y + 300, .75)
				await tween.finished
				# 关闭暂停窗口
				hide()
				return
			visible = true

func _unhandled_input(event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_visibility_changed() -> void:
	if visible:
		self.global_position.y = current_pos.y + 300
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
		tween.tween_property(self, "global_position:y", current_pos.y, .75)
		await tween.finished

	Global.is_command = true if visible else false
	get_tree().paused = true if visible else false

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.begins_with("/"):
		var command : Command = CommandParser.parse(new_text.erase(0))
		if command:
			command.excute()

	line_edit.text = ""
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
