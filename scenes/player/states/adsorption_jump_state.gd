extends State

# TODO 玩家：状态：吸附跳跃 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：吸附跳跃 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：吸附跳跃 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."

#endregion

# TODO 玩家：状态：吸附跳跃 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("==========> 玩家进入吸附跳")
	player.velocity = Vector2(player.speed * player.get_wall_normal().x, -player.jump_speed / 2)
	player.strength_model.strength -= 3 * player.strength_expend_speed
	AudioManager.sfx_play(1)

func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if player.is_dead: update_state.emit("Dead")

	if player.velocity.y > 0: update_state.emit("Fall")

func physics_update(_delta : float):
	player.velocity += player.gravity

func exit():
	pass
#endregion

# TODO 玩家：状态：吸附跳跃 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：吸附跳跃 ===============>工具方法<===============
#region 工具方法

#endregion
