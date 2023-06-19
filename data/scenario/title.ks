*title_menu|メニュー
;マクロ使用時の変数を念のため初期化
@eval exp="kag.isMessageDisplay=false"
@eval exp="tf.isPlayVoice=false"
;右クリック禁止
@rclick call=false jump=false enabled=false
;セーブ使用不可
@disablestore
;メッセージ履歴無効
@history enabled=false output=false
;メッセージ履歴の削除
@eval exp="kag.historyLayer.clear()"
;オートモードキャンセル
@cancelautomode
;レイヤー初期化(なんか関数ありそうだけど)
@LAYFORMAT
;ゲーム変数初期化
@clearvar
;動画のステータスがunloadでなければ停止
@MPGSTOP cond="kag.movies[0].lastStatus!='unload'"
;動画設定
@videolayer channel=1 page=fore layer=base
@videolayer channel=2 page=back layer=base
@video loop=true visible=true mode="layer" width=1024 height=768

;BGM再生
@BGM_FI storage="bgm001a"

;タイトルの表示
@image layer=base page=&sf.effection_page storage="back_title"
@current layer="messages0" page=&sf.effection_page
@position visible=true
;ボタン描画
@btn x=870 y=40 graphic="button_menu_information" target=*info
@eval exp="tf.buttons = ['new', 'load', 'option', 'extra', 'end']"
@eval exp="tf.i = 0"
*viewButtons
@btn x="755" y="&397 + tf.i * 64" graphic="&'button_menu_' + tf.buttons[tf.i]" target="&'*' + tf.buttons[tf.i]"
@eval exp="tf.i++"
@jump target="*viewButtons" cond="tf.i < tf.buttons.count"

@if exp="sf.effection"
@trans method=crossfade time=&sf.effection_time*1.5
@wt
@endif

@eval exp="f.ftitle = true"

@s

*info
@uall
@BG_FI storage="info147"
@waitclick
@BG_FI storage="info148"
@waitclick
@BG_FI storage="info149"
@waitclick
@uall

@jump storage="title.ks"

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
