# TODO 音乐播放器
extends Node

# TODO 音乐播放器 ===============>信 号<===============
#region 信号
signal cd_update(cd : Array[CD])
#endregion

# TODO 音乐播放器 ===============>常 量<===============
#region 常量
# SFX
const HURT = preload("res://assets/audios/SFX/Hurt.ogg")
const JUMP = preload("res://assets/audios/SFX/Jump.ogg")
const SPRINT = preload("res://assets/audios/SFX/Sprint.ogg")
const TIRED = preload("res://assets/audios/SFX/累了.ogg")
const SOLILOQUIZE = preload("res://assets/audios/SFX/自言自语.ogg")
const VANISH = preload("res://assets/audios/SFX/要消失了.ogg")
const LUMINE_FOLLOW_OF_LIGHT = preload("res://assets/audios/Lumine follow of light.ogg")
#endregion

# TODO 音乐播放器 ===============>变 量<===============
#region 变量
@export var has_cd : Array[CD]
var cd : Array[CD] = [null, null, null, null]

# 环境声的数组
@export var environments : Array[AudioStreamOggVorbis]
# 音效的数组
@export var sfxs : Array[AudioStreamOggVorbis]
# bgm播放器
@export var bgm_players: Array[AudioStreamPlayer]

@onready var other_bgm_player: AudioStreamPlayer = $OtherBGMPlayer

# sfx播放器
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer
# 环境声播放器
@onready var environment_player: AudioStreamPlayer = $EnvironmentPlayer

# 声音大小
var db : float
#endregion

# TODO 音乐播放器 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 音乐播放器 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 音乐播放器：sfx播放方法
func sfx_play(sfx_index : int) -> void:
	if not sfx_player.playing:
		sfx_player.stream = sfxs[sfx_index]
		sfx_player.play()
	else :
		var new_sfx_player : AudioStreamPlayer = AudioStreamPlayer.new()
		new_sfx_player.finished.connect(func(): new_sfx_player.queue_free())
		new_sfx_player.stream = sfxs[sfx_index]
		add_child(new_sfx_player)
		new_sfx_player.playing = true

# TODO_FUC 音乐播放器：环境声播放方法
func environment_play(environment_index : int, _position : Vector2) -> void:
	environment_player.global_position = _position
	if not environment_player.playing:
		environment_player.stream = environments[environment_index]
		environment_player.play()
		return
	db = environment_player.volume_db
	var tween_down : Tween = create_tween()
	tween_down.tween_property(environment_player, "volume_db", linear_to_db(.1), .7)
	await tween_down.finished
	environment_player.stream = environments[environment_index]
	environment_player.play()
	var tween_up : Tween = create_tween()
	tween_up.tween_property(environment_player, "volume_db", db, .7)

# TODO_FUC 音乐播放器：BGM播放方法
func bgm_play() -> void:
	if not cd: return
	for i in bgm_players:
		i.stop()
		i.stream = null

	for index in bgm_players.size():
		if bgm_players[index].playing: continue

		if cd[index] == null: continue
		bgm_players[index].stream = cd[index].cd_audio

		bgm_players[index].play()

	cd_update.emit(cd)

	#if not bgm_player.playing:
		#bgm_player.stream = bgms[bgm_index]
		#bgm_player.play()
		#return
	#db = bgm_player.volume_db
	#var tween_down : Tween = create_tween()
	#tween_down.tween_property(bgm_player, "volume_db", linear_to_db(.1), .7)
	#await tween_down.finished
	#bgm_player.stream = bgms[bgm_index]
	#bgm_player.play()
	#var tween_up : Tween = create_tween()
	#tween_up.tween_property(bgm_player, "volume_db", db, .7)

# TODO_FUC 音乐播放器：其他BGM播放方法
func other_bgm_play(other_bgm_index : int = -1) -> void:
	if other_bgm_index == -1:
		if other_bgm_player.volume_db < 0:
			var tween : Tween = create_tween()
			tween.tween_property(other_bgm_player, "volume_db", 0, 1.5)
			await tween.finished
		other_bgm_player.stream = LUMINE_FOLLOW_OF_LIGHT
		other_bgm_player.play()
	else :
		var tween : Tween = create_tween()
		tween.tween_property(other_bgm_player, "volume_db", -80, 1.5)
		await tween.finished
		other_bgm_player.stop()
		other_bgm_player.stream = null
		return
#endregion
