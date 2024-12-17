#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name RollingStonesOrgan extends ContinuousOrgan

# TODO 滚石机关 ===============>信 号<===============
#region 信号

#endregion

# TODO 滚石机关 ===============>常 量<===============
#region 常量

#endregion

# TODO 滚石机关 ===============>变 量<===============
#region 变量
# 滚石机关：移动速度
@export var speed : float
var dir : float
#endregion

# TODO 滚石机关 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	dir = randi_range(0, 1)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if is_on_floor():
		if is_on_wall():
			pass
		else :
			velocity.x = speed * (-1 if dir == 0 else 1)
	else :
		velocity.y += GlobalValue.gravity.y * 5
	move_and_slide()

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 滚石机关 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：滚石机关：玩家进入方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_hurt = true
		body.health_model.health -= 5
		await get_tree().create_timer(.15).timeout
		body.is_hurt = false
		queue_free()
#endregion

# TODO 滚石机关 ===============>工具方法<===============
#region 工具方法

#endregion
