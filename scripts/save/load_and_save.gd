extends Node

# TODO 存档系统

# TODO 存档系统:补充玩家类，完善存档系统

## 这个方法用来保存游戏数据
func save_game() -> void:
	var new_save : Save = Save.new()

	# 激活的水晶
	new_save.spawn_points = Global.spawn_points
	# 玩家坐标
	new_save.player_position = Global.player.global_position
	# 玩家存档点
	new_save.player_spawn_pos = Global.player.spawn_pos.global_position
	# 加载的CD
	new_save.cd = AudioManager.cd
	# 有的CD
	new_save.has_cd = AudioManager.has_cd
	# 玩家颜色策略
	new_save.player_color = Global.player.player_color
	# 全局重力
	new_save.gravity = GlobalValue.gravity
	# 剧情碎片
	new_save.memory_fragments = Global.memory_fragments

	# 红色对话
	new_save.red_dialogic_enabled = Global.red_dialogic_enabled

	# 追逐战
	new_save.is_war_of_pursuit = Global.is_war_of_pursuit

	# 邪恶lumine准备攻击
	new_save.evil_lumine_is_relly_attack = Global.evil_lumine_is_relly_attack

	# 跳跃教程
	new_save.learning_jumping = Global.learning_jumping

	# 漂浮教程
	new_save.learning_gliding = Global.learning_gliding

	# 冲刺教程
	new_save.learning_sprinting = Global.learning_sprinting
	# 技能点
	new_save.skill_point = GlobalValue.skill_point
	# 使用的技能点
	new_save.used_skill_point = GlobalValue.used_skill_point
	# 玩家等级
	new_save.player_level = GlobalValue.player_level
	# 玩家经验
	new_save.e_x_p = Global.player.level_model.e_x_p
	# 生命上限
	new_save.player_luminance_level = GlobalValue.player_luminance_level
	# 体力上限
	new_save.player_strength_level = GlobalValue.player_strength_level
	# 冲刺CD
	new_save.player_sprint_cd_level = GlobalValue.player_sprint_cd_level
	# 跳跃高度
	new_save.player_jump_height_level = GlobalValue.player_jump_height_level
	# 体力恢复
	new_save.player_strength_recover_level = GlobalValue.player_strength_recover_level
	# 血量减少
	new_save.player_health_expend_level = GlobalValue.player_health_expend_level
	# 体力减少
	new_save.player_strength_expend_level = GlobalValue.player_strength_expend_level
	# 吸附下落
	new_save.player_adsorp_down_level = GlobalValue.player_adsorp_down_level
	# 空中转体
	new_save.can_air_twist = GlobalValue.can_air_twist
	# 二段跳
	new_save.can_double_jump = GlobalValue.can_double_jump
	# 吸附跳
	new_save.can_adsorption_jump = GlobalValue.can_adsorption_jump
	# 破坏激光
	new_save.can_ray_destory = GlobalValue.can_ray_destory
	# 交互激光
	new_save.can_ray_interact = GlobalValue.can_ray_interact
	# 光明Buff
	new_save.health_buff_level = GlobalValue.health_buff_level
	# 远冲Buff
	new_save.sprint_buff_level = GlobalValue.sprint_buff_level
	# 充沛Buff
	new_save.abundant_buff_level = GlobalValue.abundant_buff_level
	# 连冲Buff
	new_save.continue_sprint_buff_level = GlobalValue.continue_sprint_buff_level
	# 羽落Buff
	new_save.feather_fall_buff_level = GlobalValue.feather_fall_buff_level
	# 强电Buff
	new_save.ray_destroy_time_level = GlobalValue.ray_destroy_time_level

	ResourceSaver.save(new_save, "user://save_game_1.tres")

func has_save() -> bool:
	return FileAccess.file_exists("user://save_game_1.tres")

## 这个方法用来加载游戏数据
func load_game() -> void:
	if FileAccess.file_exists("user://save_game_1.tres"):
		var old_save : Save = load("user://save_game_1.tres") as Save

		Global.spawn_points = old_save.spawn_points
		Global.player.global_position = old_save.player_position
		Global.player.spawn_pos.global_position = old_save.player_spawn_pos
		AudioManager.cd = old_save.cd
		AudioManager.has_cd = old_save.has_cd
		Global.player.player_color = old_save.player_color
		GlobalValue.gravity = old_save.gravity
		# 剧情碎片
		Global.memory_fragments = old_save.memory_fragments
		# 红色对话
		Global.red_dialogic_enabled = old_save.red_dialogic_enabled
		# 追逐战
		Global.is_war_of_pursuit = old_save.is_war_of_pursuit
		# 邪恶lumine准备攻击
		Global.evil_lumine_is_relly_attack = old_save.evil_lumine_is_relly_attack
		# 跳跃教程
		Global.learning_jumping = old_save.learning_jumping
		# 漂浮教程
		Global.learning_gliding = old_save.learning_gliding
		# 冲刺教程
		old_save.learning_sprinting = Global.learning_sprinting
		GlobalValue.skill_point = old_save.skill_point
		GlobalValue.used_skill_point = old_save.used_skill_point
		GlobalValue.player_level = old_save.player_level
		Global.player.level_model.level = old_save.player_level
		Global.player.level_model.e_x_p = old_save.e_x_p
		GlobalValue.player_luminance_level = old_save.player_luminance_level
		GlobalValue.player_strength_level = old_save.player_strength_level
		GlobalValue.player_sprint_cd_level = old_save.player_sprint_cd_level
		GlobalValue.player_jump_height_level = old_save.player_jump_height_level
		GlobalValue.player_strength_recover_level = old_save.player_strength_recover_level
		GlobalValue.player_health_expend_level = old_save.player_health_expend_level
		GlobalValue.player_strength_expend_level = old_save.player_strength_expend_level
		GlobalValue.player_adsorp_down_level = old_save.player_adsorp_down_level
		GlobalValue.can_air_twist = old_save.can_air_twist
		GlobalValue.can_double_jump = old_save.can_double_jump
		GlobalValue.can_adsorption_jump = old_save.can_adsorption_jump
		GlobalValue.can_ray_interact = old_save.can_ray_interact
		GlobalValue.can_ray_destory = old_save.can_ray_destory
		GlobalValue.health_buff_level = old_save.health_buff_level
		GlobalValue.sprint_buff_level = old_save.sprint_buff_level
		GlobalValue.abundant_buff_level = old_save.abundant_buff_level
		GlobalValue.continue_sprint_buff_level = old_save.continue_sprint_buff_level
		GlobalValue.feather_fall_buff_level = old_save.feather_fall_buff_level
		GlobalValue.ray_destroy_time_level = old_save.ray_destroy_time_level

func save_config() -> void:
	var new_config : Config = Config.new()

	new_config.ambient_volume = Global.ambient_volume
	new_config.bgm_volume = Global.bgm_volume
	new_config.main_volume = Global.main_volume
	new_config.sfx_volume = Global.sfx_volume

	new_config.is_ambient_volume = Global.is_ambient_volume
	new_config.is_bgm_volume = Global.is_bgm_volume
	new_config.is_main_volume = Global.is_main_volume
	new_config.is_sfx_volume = Global.is_sfx_volume

	new_config.full_screen_enabled = Global.full_screen_enabled
	new_config.camera_mode_enabled = Global.camera_mode_enabled
	new_config.glow_enabled = Global.glow_enabled
	new_config.key_tip_enabled = Global.key_tip_enabled

	ResourceSaver.save(new_config, "user://config.tres")

func load_config() -> void:
	if FileAccess.file_exists("user://config.tres"):
		var old_config : Config = load("user://config.tres") as Config

		Global.ambient_volume = old_config.ambient_volume
		Global.bgm_volume = old_config.bgm_volume
		Global.main_volume = old_config.main_volume
		Global.sfx_volume = old_config.sfx_volume

		Global.is_ambient_volume = old_config.is_ambient_volume
		Global.is_bgm_volume = old_config.is_bgm_volume
		Global.is_main_volume = old_config.is_main_volume
		Global.is_sfx_volume = old_config.is_sfx_volume

		Global.full_screen_enabled = old_config.full_screen_enabled
		Global.camera_mode_enabled = old_config.camera_mode_enabled
		Global.glow_enabled = old_config.glow_enabled
		Global.key_tip_enabled = old_config.key_tip_enabled

func has_config() -> bool:
	return FileAccess.file_exists("user://config.tres")
