extends State

# TODO 玩家：状态：死亡 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：死亡 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：死亡 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."

#endregion

# TODO 玩家：状态：死亡 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("===========> 玩家进入死亡")

	player.velocity = Vector2.ZERO

	# 使用 Tween 实现将玩家传送回存档点
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK).set_parallel()
	tween.tween_property(player, "scale", Vector2.ZERO, 0.75)
	tween.chain().tween_property(player, "global_position", player.spawn_pos.global_position, 0.75)
	tween.chain().tween_property(player, "scale", Vector2.ONE, 0.75)

	player.health_model.reset_health()
	player.strength_model.reset_strength()

	await tween.finished

	# 当回到存档点进入待机状态
	update_state.emit("Idle")

func update(_delta : float):
	pass

func physics_update(_delta : float):
	pass

func exit():
	# 重置玩家血量、体力
	player.reset_value()
	player.is_dead = false
#endregion

# TODO 玩家：状态：死亡 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：死亡 ===============>工具方法<===============
#region 工具方法

#endregion
