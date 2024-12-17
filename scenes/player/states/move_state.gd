extends State

# TODO 玩家：状态：移动 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：移动 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：移动 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."
#endregion

# TODO 玩家：状态：移动 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("===========> 玩家进入移动")

func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if player.is_dead: update_state.emit("Dead")

	if is_zero_approx(player.dir): update_state.emit("Idle")

	if player.is_jump and player.strength_model.strength > 0 and not player.cant_jump:
		update_state.emit("Jump")

	if player.is_sprint: update_state.emit("Sprint")

func physics_update(_delta : float):
	player.velocity += (player.gravity + player.ex_gravity)
	if player.dir:
		player.velocity.x = lerp(player.velocity.x, player.dir * player.speed, .1)

func exit():
	pass
#endregion

# TODO 玩家：状态：移动 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：移动 ===============>工具方法<===============
#region 工具方法

#endregion
