#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name MovableBlockOrgan extends ContinuousOrgan

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
var player : Player
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
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
	if not is_on_floor():
		velocity.y += GlobalValue.gravity.y * 5
	if player and player.interact:
		f_tip_panel_container.hide()
		if player.global_position.y > global_position.y:
			velocity.y = lerp(velocity.y, 0., .1)
			if player.global_position.x > global_position.x:
				velocity.x -= 1
			else :
				velocity.x += 1
		player.speed = 150
		velocity.x = player.dir * 150
	else :
		velocity = lerp(velocity, Vector2.ZERO, .1)
	move_and_slide()

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.key_tip_enabled:
			f_tip_panel_container.show()
		player = body

# TODO_FUC
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		f_tip_panel_container.hide()
		body.speed = 350
		player = null
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
