#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name DisappearPlateOrgan extends TriggerOrgan

# TODO 机关：消失板 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关：消失板 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关：消失板 ===============>变 量<===============
#region 变量
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var distroy_plate : Callable = func():
	sprite_2d.visible = false
	collision_shape_2d.set_deferred("disabled", true)
	_is_visible = false
var create_plate : Callable = func():
	sprite_2d.visible = true
	collision_shape_2d.disabled = false
	_is_visible = true
var _is_visible : bool = false :
	set(v):
		_is_visible = v
		if not _is_visible:
			get_tree().create_timer(5.).timeout.connect(create_plate)
#endregion

# TODO 机关：消失板 ===============>虚方法<===============
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

# TODO 机关：消失板 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：消失板：玩家进入方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().create_timer(3.).timeout.connect(distroy_plate)
#endregion

# TODO 机关：消失板 ===============>工具方法<===============
#region 工具方法

#endregion
