;回想モード
*scenemode
;BGM再生
@BGM_FI storage="bgm001"
;メッセージ履歴無効
@history enabled=false output=false
;メッセージ履歴の削除
@eval exp="kag.historyLayer.clear()"
;現在のページを初期化
@eval exp="sf.scenemode_page_num=0" cond="sf.scenemode_page_num===void"
*loadimage
;背景読込
@lsg storage=scene
;右クリック
@rclick call=false jump=false storage=scenemode.ks enabled=false

@current layer=message0 page="&sf.effection_page"
@cm
@position left=0 top=0 marginl=0 margint=0 marginr=0 width=&kag.innerWidth height=&kag.innerHeight frame="" visible=true
@layopt layer=message0 page="&sf.effection_page" opacity=255
@btn x=771 y=65 graphic="button_return_e" target="*rc"

@nowait

@iscript
{
	// 各回想サムネイル
	var recollects = [
		"scene_ev001a", "scene_ev002a", "scene_ev003a", "scene_ev004a", "scene_ev006a",
		"scene_ev007a", "scene_ev008a", "scene_ev009a", "scene_ev010a", "scene_ev011a",
		"scene_ev012a", "scene_ev013a", "scene_ev014a",	"scene_ev015a", "scene_ev016a",
		"scene_ev017a", "scene_ev018a", "scene_ev019a",	"scene_ev020a"
	];
	// 座標
	var x = 153, xAdd = 179;
	var y = 179, yAdd = 134;
	// 表示数
	var line = 4, row = 4, num = recollects.length;
	var pageNum = line * row;
	// limitとoffsetの算出
	var offset = line * row * sf.scenemode_page_num;
	var limit = line * row + offset;
	// ページ数の算出
	tf.scenemode_page_num_max = (int) Math.ceil(recollects.length / pageNum);

	// 描画処理
	with(kag.tagHandlers)
	{
		// 各サムネイルボタン
		var links = kag.current.links.length;
		for(var i = offset; i < recollects.count && i < limit; i++)
		{
			.button(%[
				x:x + (i - offset) % row * xAdd, y:y + (i - offset) \ row * yAdd,
				graphic:"gallery_thumb", target:"*jump", exp:"tf.storage='scenario.ks', tf.target='*recollection" + (i + 1) + "'",
				invalidDown:true, invalidOn:true
			]);
			var btn = kag.current.links[links + i - offset].object;
			if(sf['recollection' + (i + 1)])
			{
				// サムネイル
				var tmp = kag.tempLayer;
				tmp.loadImages(recollects[i]);
				tmp.setSizeToImageSize();
				btn.copyRect(1, 1, tmp, 0, 0, tmp.width, tmp.height);
			} else
			{
				btn.enable = false;
			}
		}
		// 前のページへボタン
		if(sf.scenemode_page_num > 0)
		{
			.button(%[x:10,  y:420, graphic:"button_pager_prev", target:"*loadimage", exp:"sf.scenemode_page_num--", invalidDown:true]);
		}
		// 次のページへボタン
		if(sf.scenemode_page_num < tf.scenemode_page_num_max - 1)
		{
			.button(%[x:970, y:420, graphic:"button_pager_next", target:"*loadimage", exp:"sf.scenemode_page_num++", invalidDown:true]);
		}
	}
	// 現在のページ数の表示
	if(tf.scenemode_page_num_max > 1)
	{
		with(kag[sf.effection_page].base) {
			.font.height = 14;
			.drawText(480, 150, "PAGE" + (sf.scenemode_page_num + 1), 0xffffff, 255, true, 4096, 0xa22954, 2);
		}
	}

	// デバッグコード(回想フラグ切り替え)
	tf.recollects = recollects;
	function chgS(flag = true) {
		hideLayers("fore");
		hideMessages("fore");
		var tempLayer = new Layer(kag, kag.fore.layers[0]);
		tempLayer.setSize(166, 125);

		for(var i = 0; i < tf.recollects.count; i++) {
			sf["recollection"+(i+1)] = flag;

			kag.fore.base.fillRect(0, 0, kag.innerWidth, kag.innerHeight, 0x000000);
			var storageName = tf.recollects[i];
			kag.tagHandlers.ptext(%[x:115, y:280, layer:"base", size:142, text:storageName]);
			tempLayer.stretchCopy(0, 0, tempLayer.width, tempLayer.height, kag.fore.base, 0, 0, kag.innerWidth, kag.innerHeight);
			tempLayer.saveLayerImage("evimage/" + storageName + ".bmp","bmp24");
		}
	}
}
@endscript

@font size=default

@if exp="sf.effection"
@trans method=crossfade time=500
@wt
@endif

;右クリック
@rclick call=false jump=true target="*rc" enabled=true

@s

;回想へジャンプ
*jump
;栞を無効
@store enabled=false

@uall
@BGM_FO

;タイトルフラグをオフに
@eval exp="f.ftitle = false"
;右クリック設定サブルーチン呼び出し
@rclick call=false jump=false enabled=true
;メッセージ履歴有効
@history enabled=true output=true
;メッセージレイヤー設定
@current layer=message0
@M_SET
@backlay

;@layopt layer=message0 page=back visible=true
;@layopt layer=message1 page=back visible=true
@M_FI
@eval exp="tf.scene_mode=true"
@jump storage=&tf.storage target=&tf.target

;回想から戻る
*return
@MPGSTOP cond="kag.movies[0].lastStatus!='unload'"
@videolayer channel=1 page=fore layer=base
@videolayer channel=2 page=back layer=base
@video loop=true visible=true mode="layer" width=1024 height=768
;右クリック無効
@rclick call=false jump=false enabled=false
@uall
@BGM_FO
@eval exp="tf.scene_mode=false"
;タイトルフラグをオンに
@eval exp="f.ftitle = true"
;オートモードキャンセル
@cancelautomode
;カットインフラグを下ろす
@eval exp="f.viewcutin=void"
@jump target="*scenemode"

;おまけ選択画面に戻る
*rc
;リンクをロック
@locklink
;右クリック無効
@rclick call=false jump=false enabled=false
@uall
@jump storage="extra.ks"
