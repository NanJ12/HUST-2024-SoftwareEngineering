extends State

# TODO 玩家：状态：跳跃 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：跳跃 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：跳跃 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."
#endregion

# TODO 玩家：状态：跳跃 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("==========> 玩家进入跳跃状态")
	player.velocity.y = player.jump_speed * -1
	player.jump_count -= 1
	player.strength_model.strength -= 2 * player.strength_expend_speed
	AudioManager.sfx_play(1)

func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if player.is_dead: update_state.emit("Dead")

	if \
	player.is_on_wall_only() and\
	player.is_adsorption and\
	player.jump_count > 0 and\
	player.strength_model.strength > 0 and\
	GlobalValue.can_adsorption_jump:
		update_state.emit("Adsorption")

	if player.velocity.y > 0: update_state.emit("Fall")

	if \
	player.jump_count > 0 and \
	Input.is_action_just_pressed("action_jump") and \
	player.strength_model.strength > 0 and\
	GlobalValue.can_double_jump:
		update_state.emit("DoubleJump")

func physics_update(_delta : float):
	player.velocity += (player.gravity + player.ex_gravity)

	if player.dir and GlobalValue.can_air_twist:
		player.velocity.x = lerp(player.velocity.x, player.dir * player.speed, .1)

func exit():
	pass
#endregion

# TODO 玩家：状态：跳跃 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：跳跃 ===============>工具方法<===============
#region 工具方法

#endregion
