# FIXME 先不用，后面还要改一改这个飞行状态的逻辑
extends State

# TODO 玩家：状态：飞行 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：飞行 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：飞行 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."

#endregion

# TODO 玩家：状态：飞行 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("==========> 玩家进入飞行")

func update(_delta : float):
	if player.is_dead: update_state.emit("Dead")

	if player.is_hurt: update_state.emit("Hurt")

	if not player.is_fly: update_state.emit("Idle")

	if player.strength_model.strength == 0: update_state.emit("Fall")

func physics_update(_delta : float):
	if not player.is_on_floor():
		player.strength_model.strength -= _delta * 15
	else :
		player.strength_model.strength += _delta * 10

	if Input.is_action_pressed("action_u") and not player.is_on_ceiling():
		player.velocity -= player.gravity
	elif Input.is_action_pressed("action_d") and not player.is_on_floor():
		player.velocity += player.gravity
	else :
		player.velocity.y -= lerp(player.velocity.y, 0., .1)

	if player.dir:
		player.velocity.x = lerp(player.velocity.x, player.dir * 300, .1)
	else :
		player.velocity.x = lerp(player.velocity.x, 0., .1)

func exit():
	pass
#endregion

# TODO 玩家：状态：飞行 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：飞行 ===============>工具方法<===============
#region 工具方法

#endregion
