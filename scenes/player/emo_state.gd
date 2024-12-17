extends State

# TODO 玩家：状态：情绪 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：情绪 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：情绪 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."
#endregion

# TODO 玩家：状态：情绪 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("==========> 玩家进入情绪")

	# WARNING 这里的Emo状态需要后面补上对应的音效
	if player.strength_model.strength < player.strength_model.max_strength * .2:
		UiTool.fly_text(player.global_position + Vector2(0, -96), "我有点累了。", 1., 32, Color.DARK_BLUE)
		AudioManager.sfx_play(3)
		await get_tree().create_timer(3).timeout
		update_state.emit("Idle")
		return
	elif player.health_model.health < player.health_model.max_health * .2:
		UiTool.fly_text(player.global_position + Vector2(0, -96), "好像要没能量了。", 1., 32, Color.DARK_BLUE)
		AudioManager.sfx_play(5)
		await get_tree().create_timer(3).timeout
		update_state.emit("Idle")
		return

	var emo_index : int = randi() % 2
	match emo_index:
		0:
			UiTool.fly_text(player.global_position + Vector2(0, -96), "你为什么不动？", 1., 32, Color.DARK_BLUE)
		1:
			UiTool.fly_text(player.global_position + Vector2(0, -96), "为什么只有我可以点亮光水晶？", 1., 32, Color.DARK_BLUE)
	AudioManager.sfx_play(4)
	await get_tree().create_timer(3).timeout
	update_state.emit("Idle")


func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if player.is_dead: update_state.emit("Dead")

	if player.dir: update_state.emit("Move")

	if player.is_jump and player.strength_model.strength > 0: update_state.emit("Jump")

	if not player.is_on_floor(): update_state.emit("Fall")

func physics_update(_delta : float):
	player.velocity += player.gravity
	player.velocity.x = lerp(player.velocity.x, 0., .1)

	if player.strength_model.strength <= player.strength_model.max_strength:
		player.strength_model.strength += _delta * player.strength_model.strength_recover_speed

func exit():
	pass
#endregion

# TODO 玩家：状态：情绪 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：情绪 ===============>工具方法<===============
#region 工具方法

#endregion
