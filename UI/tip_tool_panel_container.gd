#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name TipToolPanelContainer extends PanelContainer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
var title_label: Label
var texture_rect: TextureRect
var paragraph_label: Label
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

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

#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
# TODO_FUC
func set_tip_tool(_name : String, para : String, texture : Texture = null) -> void:
	title_label = %TitleLabel
	texture_rect = %TextureRect
	paragraph_label = %ParagraphLabel

	title_label.text = _name
	paragraph_label.text = para
	if texture != null:
		texture_rect.texture = texture
#endregion