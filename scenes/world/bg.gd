#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends Node2D

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var red_bg: Node2D = $RedBG
@onready var cyan_bg: Node2D = $CyanBG
@onready var orange_bg: Node2D = $OrangeBG
@onready var purple_bg: Node2D = $PurpleBG

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
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_red_area_2d_body_entered(_body: Node2D) -> void:
	red_bg_show()

func _on_cyan_area_2d_body_entered(_body: Node2D) -> void:
	cyan_bg_show()

func _on_orange_area_2d_body_entered(_body: Node2D) -> void:
	orange_bg_show()

func _on_purple_area_2d_body_entered(_body: Node2D) -> void:
	purple_bg_show()

#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func red_bg_show() -> void:
	if not red_bg.visible:
		red_bg.show()
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
		tween.tween_property(red_bg, "modulate:a", 1., 1.)
		tween.tween_property(cyan_bg, "modulate:a", 0., 1.)
		tween.tween_property(orange_bg, "modulate:a", 0., 1.)
		tween.tween_property(purple_bg, "modulate:a", 0., 1.)
		await tween.finished
		cyan_bg.hide()
		orange_bg.hide()
		purple_bg.hide()

func cyan_bg_show() -> void:
	if not cyan_bg.visible:
		cyan_bg.show()
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
		tween.tween_property(cyan_bg, "modulate:a", 1., 1.)
		tween.tween_property(red_bg, "modulate:a", 0., 1.)
		tween.tween_property(orange_bg, "modulate:a", 0., 1.)
		tween.tween_property(purple_bg, "modulate:a", 0., 1.)
		await tween.finished
		red_bg.hide()
		orange_bg.hide()
		purple_bg.hide()

func orange_bg_show() -> void:
	if not orange_bg.visible:
		orange_bg.show()
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
		tween.tween_property(orange_bg, "modulate:a", 1., 1.)
		tween.tween_property(red_bg, "modulate:a", 0., 1.)
		tween.tween_property(cyan_bg, "modulate:a", 0., 1.)
		tween.tween_property(purple_bg, "modulate:a", 0., 1.)
		await tween.finished
		red_bg.hide()
		cyan_bg.hide()
		purple_bg.hide()

func purple_bg_show() -> void:
	if not purple_bg.visible:
		purple_bg.show()
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
		tween.tween_property(purple_bg, "modulate:a", 1., 1.)
		tween.tween_property(red_bg, "modulate:a", 0., 1.)
		tween.tween_property(cyan_bg, "modulate:a", 0., 1.)
		tween.tween_property(orange_bg, "modulate:a", 0., 1.)
		await tween.finished
		red_bg.hide()
		cyan_bg.hide()
		orange_bg.show()
#endregion
