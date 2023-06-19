;タイトルの表示
@image layer=base page=&sf.effection_page storage="back_title"
@current layer="messages0" page=&sf.effection_page
@position visible=true
;ボタン描画
@btn x=874 y=0 graphic="button_menu_information" target=*info
@eval exp="tf.buttons = ['new', 'load', 'option', 'extra', 'end']"
@eval exp="tf.i = 0"
*viewButtons
@btn x="742" y="&454 + tf.i * 58" graphic="&'button_menu_' + tf.buttons[tf.i]" target="&'*' + tf.buttons[tf.i]"
@eval exp="tf.i++"
@jump target="*viewButtons" cond="tf.i < tf.buttons.count"

@if exp="sf.effection"
@trans method=crossfade time=&sf.effection_time*1.5
@wt
@endif

@eval exp="f.ftitle = true"

@s

@jump storage="title_gra.ks"


*new
@uall
@BGM_FO
@eval exp="f.ftitle = false"
@eval exp="kag.snapshotLockCount = 0"
@jump storage="scenario.ks"

*load
@uall
@jump storage="sub.ks" target="*load"

*option
@uall
@jump storage="sub.ks" target="*option"

*extra
@uall
@jump storage="extra.ks"

*end
@close
@unlocklink
@s

*info
@jump storage="title_gra.ks"