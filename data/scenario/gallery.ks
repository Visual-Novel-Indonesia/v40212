;ギャラリー

;メッセージ履歴無効
@history enabled=false output=false
;メッセージ履歴の削除
@eval exp="kag.historyLayer.clear()"
;現在のページを初期化
@eval exp="sf.gallery_page = 0" cond="sf.gallery_page === void"
;右クリック無効
@rclick call=false jump=false storage=gallery.ks enabled=false

@iscript
{
	tf.cgs = [
		["ev001a", "ev001b", "ev001c", "ev001d", "ev001e", "ev001f", "ev001g", "ev001h", "ev001i", "ev001j", "ev001k"],
		["ev002a", "ev002b", "ev002c", "ev002d", "ev002e", "ev002f", "ev002g", "ev002h", "ev002i"],
		["ev003a", "ev003b", "ev003c", "ev003d", "ev003e", "ev003f", "ev003g", "ev003h", "ev003i", "ev003j"],
		["ev004a", "ev004b", "ev004c", "ev004d", "ev004e", "ev004f", "ev004g", "ev004h", "ev004i"],
		["ev005a", "ev005b", "ev005c", "ev005d", "ev005e", "ev005f", "ev005g", "ev005h", "ev005i", "ev005j", "ev005k", "ev005l", "ev005m", "ev005n", "ev005o", "ev005p"],
		["ev006a", "ev006b", "ev006c", "ev006d", "ev006e", "ev006f", "ev006g", "ev006h", "ev006i"],
		["ev007a", "ev007b", "ev007c", "ev007d", "ev007e", "ev007f"],
		["ev008a", "ev008b", "ev008c", "ev008d", "ev008e", "ev008f", "ev008g", "ev008h", "ev008i", "ev008j", "ev008k"],
		["ev009a", "ev009b", "ev009c", "ev009d", "ev009e", "ev009f", "ev009g", "ev009h"],
		["ev010a", "ev010b", "ev010c", "ev010d"],
		["ev011a", "ev011b", "ev011c", "ev011d", "ev011e"],
		["ev012a", "ev012b", "ev012c", "ev012d", "ev012e", "ev012f", "ev012g", "ev012h"],
		["ev013a", "ev013b", "ev013c", "ev013d", "ev013e", "ev013f", "ev013g", "ev013h", "ev013i"],
		["ev014a", "ev014b", "ev014c", "ev014d", "ev014e", "ev014f", "ev014g", "ev014h", "ev014i", "ev014j"],
		["ev015a", "ev015b", "ev015c", "ev015d", "ev015e", "ev015f", "ev015g", "ev015h", "ev015i"],
		["ev016a", "ev016b", "ev016c", "ev016d", "ev016e"],
		["ev017a", "ev017b", "ev017c", "ev017d", "ev017e", "ev017f"],
		["ev018a", "ev018b", "ev018c", "ev018d", "ev018e"],
		["ev019a", "ev019b", "ev019c", "ev019d", "ev019e"],
		["ev020a", "ev020b", "ev020c", "ev020d", "ev020e", "ev020f", "ev020g", "ev020h", "ev020i", "ev020j", "ev020k", "ev020l", "ev020m", "ev020n", "ev020o"]
	];

	function nextJump(num)
	{
		if (num === void) return void;
		var num1 = num.num1;
		var i = num.num2 !== void ? num.num2 + 1 : 0;
		for(; i < tf.cgs[num1].length; i++)
		{
			if(sf[tf.cgs[num1][i]]) {
				return %[num1: num1, num2: i];
			}
		}
		return void;
	}

	// デバッグコード(ダミー生成とサムネイル生成/フラグ調整)
	function mkEg(withFlag = true, withThumb = true) {
		hideLayers("fore");
		hideMessages("fore");
		var tempLayer = new Layer(kag, kag.fore.layers[0]);
		tempLayer.setSize(166, 125);
		for (var i = 0; i < tf.cgs.count; i++) {
			for (var j = 0; j < tf.cgs[i].count; j++) {
				kag.fore.base.fillRect(0, 0, kag.innerWidth, kag.innerHeight, 0x000000);
				var storageName = tf.cgs[i][j];
				kag.tagHandlers.ptext(%[x:115, y:243, layer:"base", size:192, text:storageName]);
				kag.fore.base.saveLayerImage("evimage/" + storageName +".bmp", "bmp24");
				if (withFlag) {
					sf[storageName] = 1;
					sf[storageName.substring(0, storageName.length - 1)]++;
				}
				if (withThumb && j == 0) {
					tempLayer.stretchCopy(0, 0, tempLayer.width, tempLayer.height, kag.fore.base, 0, 0, kag.innerWidth, kag.innerHeight);
					tempLayer.saveLayerImage("evimage/s_" + storageName + ".bmp","bmp24");
				}
			}
		}
	}
}
@endscript

*gallery
@lsg storage=gallery

@current layer=message0 page="&sf.effection_page"
@position visible=true

@iscript
{
	// 座標
	var x = 153, xAdd = 179;
	var y = 179, yAdd = 134;
	// 表示数
	var line = 4, row = 4, num = tf.cgs.length;
	var maxPage = (num + (line * row - 1)) \ (line * row);
	var offset = line * row * sf.gallery_page;
	var limit = line * row + offset;
	// 描画処理
	with(kag.tagHandlers)
	{
		// 戻るボタン
		.button(%[x:771, y:65, graphic:"button_return_e", target:"*rc", invalidDown:true]);
		// 各サムネイルボタン
		var links = kag.current.links.length;
		for(var i = offset; i < num && i < limit; i++)
		{
			var storage = tf.cgs[i][0].substring(0, 5);
			.button(%[
				x:x + (i - offset) % row * xAdd, y:y + (i - offset) \ row * yAdd,
				graphic:"gallery_thumb", target:"*load", exp:"tf.now = %[num1: " + i + "]",
				invalidDown:true, invalidOn:true
			]);
			var btn = kag.current.links[links + i - offset].object;
			if(sf[storage])
			{
				// サムネイル
				var tmp = kag.tempLayer;
				tmp.loadImages("s_" + storage + "a");
				tmp.setSizeToImageSize();
				btn.copyRect(1, 1, tmp, 0, 0, tmp.width, tmp.height);
			} else
			{
				btn.enable = false;
			}
		}
		// 前のページへボタン
		if(sf.gallery_page > 0)
		{
			.button(%[x:45,  y:421, graphic:"button_pager_prev", target:"*gallery", exp:"sf.gallery_page--", invalidDown:true]);
		}
		// 次のページへボタン
		if(sf.gallery_page < maxPage - 1)
		{
			.button(%[x:953, y:421, graphic:"button_pager_next", target:"*gallery", exp:"sf.gallery_page++", invalidDown:true]);
		}
		// 現在のページ数の表示
		if(maxPage > 1)
		{
			with(kag.current) {
				.font.height = 15;
				.drawText(486, 141, 'PAGE' + (sf.gallery_page + 1), 0xffffff, 255, true, 2000, 0xa22954 , 2, 0, 0);
			}
		}
	}
}
@endscript

@if exp="sf.effection"
@trans method=crossfade time="& sf.effection_time \ 2"
@wt
@endif

;右クリック
@rclick call=false jump=true target="*rc" enabled=true

@s

;表示
*load
@rclick call=false jump=false enabled=false
@uall time="& sf.effection_time \ 2"
@eval exp="dm('1:' + tf.now.num2)"
@eval exp="tf.now = nextJump(tf.now)"
@eval exp="dm('2:' + tf.now.num2)"
@lbg storage="&tf.cgs[tf.now.num1][tf.now.num2]"
@rclick call=false jump=true target="*exit" enabled=true
;オートモードキャンセル
@cancelautomode
;@eval exp="kag.notifyStable()"
@eval exp="kag.inStable=true"
@waitclick
@rclick call=false jump=false enabled=false
@eval exp="dm('3:' + tf.now.num2)"
@jump target=*load cond="nextJump(tf.now) !== void"
*exit
@rclick call=false jump=false enabled=false
@uall time="& sf.effection_time \ 2"
@jump target=*gallery

*rc
@rclick call=false jump=false enabled=false
@uall
@jump storage="extra.ks"
