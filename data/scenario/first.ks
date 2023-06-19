;定義諸々

;マクロ読み込み
@call storage="macro.ks"

;初回起動か否か
;-------------------------------------------------
@ignore exp="sf.first_boot"

;画面効果変数を初期化する
@eval exp="sf.effection = true"
@eval exp="sf.effection_page = 'back'"
;回想用変数初期化
@eval exp="sf.recollect = []"
;大域ボリューム初期化
@bgmopt gvolume=50
@seopt buf=0 gvolume=50
@seopt buf=1 gvolume=50
@seopt buf=2 gvolume=50
;セーブロードの表示ページを初期化
@eval exp="sf.save_now_page = 0"
;メッセージレイヤーの不透明度
@eval exp="sf.msg_opacity = 153"
;カットインの表示設定
@eval exp="sf.cutin = true"

@eval exp="sf.first_boot = true"

@endignore
;-------------------------------------------------
;初回起動時のみの設定終了

;ページ毎のセーブ最大数
@eval exp="sf.save_max_page = 9"

;フェード基準時間
@eval exp="sf.effection_time = 1000"

*start|スタート
@wait time=500
@lbg storage="op01" time=5000
@lbg storage="white" time=1000
@lbg storage="op02" time=5000
@lbg storage="white" time=1000
@lbg storage="ippa" time=5000
@lbg storage="white" time=1000
@lbg
@jump storage="title.ks"
