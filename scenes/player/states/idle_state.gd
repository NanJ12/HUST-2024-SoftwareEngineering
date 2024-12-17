extends State

# TODO 玩家：状态：待机 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：待机 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：待机 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."
var emo_time : float = 5
#endregion

# TODO 玩家：状态：待机 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("===========> 玩家进入待机")
	player.jump_count = 2
	emo_time = 5

func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if player.is_fly and not Dialogic.dialogic_is_playing: update_state.emit("Fly")

	if player.is_dead: update_state.emit("Dead")

	if player.dir and not player.is_fly and not Dialogic.dialogic_is_playing: update_state.emit("Move")

	if player.is_jump and\
	 player.strength_model.strength > 0 and\
	 not player.cant_jump and\
	 not player.is_fly and\
	 not Dialogic.dialogic_is_playing:
		update_state.emit("Jump")

	if not player.is_on_floor(): update_state.emit("Fall")

func physics_update(_delta : float):
	player.velocity += (player.gravity + player.ex_gravity)
	player.velocity.x = lerp(player.velocity.x, 0., .1)

	if player.strength_model.strength <= player.strength_model.max_strength:
		player.strength_model.strength += _delta * player.strength_model.strength_recover_speed

	if emo_time > 0 and not Dialogic.visible:
		emo_time -= _delta
		if emo_time <= 0:
			emo_time = 5
			update_state.emit("Emo")

func exit():
	pass
#endregion

# TODO 玩家：状态：待机 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：待机 ===============>工具方法<===============
#region 工具方法

#endregion
