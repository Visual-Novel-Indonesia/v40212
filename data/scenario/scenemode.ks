;��z���[�h
*scenemode
;BGM�Đ�
@BGM_FI storage="bgm001"
;���b�Z�[�W���𖳌�
@history enabled=false output=false
;���b�Z�[�W�����̍폜
@eval exp="kag.historyLayer.clear()"
;���݂̃y�[�W��������
@eval exp="sf.scenemode_page_num=0" cond="sf.scenemode_page_num===void"
*loadimage
;�w�i�Ǎ�
@lsg storage=scene
;�E�N���b�N
@rclick call=false jump=false storage=scenemode.ks enabled=false

@current layer=message0 page="&sf.effection_page"
@cm
@position left=0 top=0 marginl=0 margint=0 marginr=0 width=&kag.innerWidth height=&kag.innerHeight frame="" visible=true
@layopt layer=message0 page="&sf.effection_page" opacity=255
@btn x=771 y=65 graphic="button_return_e" target="*rc"

@nowait

@iscript
{
	// �e��z�T���l�C��
	var recollects = [
		"scene_ev001a", "scene_ev002a", "scene_ev003a", "scene_ev004a", "scene_ev006a",
		"scene_ev007a", "scene_ev008a", "scene_ev009a", "scene_ev010a", "scene_ev011a",
		"scene_ev012a", "scene_ev013a", "scene_ev014a",	"scene_ev015a", "scene_ev016a",
		"scene_ev017a", "scene_ev018a", "scene_ev019a",	"scene_ev020a"
	];
	// ���W
	var x = 153, xAdd = 179;
	var y = 179, yAdd = 134;
	// �\����
	var line = 4, row = 4, num = recollects.length;
	var pageNum = line * row;
	// limit��offset�̎Z�o
	var offset = line * row * sf.scenemode_page_num;
	var limit = line * row + offset;
	// �y�[�W���̎Z�o
	tf.scenemode_page_num_max = (int) Math.ceil(recollects.length / pageNum);

	// �`�揈��
	with(kag.tagHandlers)
	{
		// �e�T���l�C���{�^��
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
				// �T���l�C��
				var tmp = kag.tempLayer;
				tmp.loadImages(recollects[i]);
				tmp.setSizeToImageSize();
				btn.copyRect(1, 1, tmp, 0, 0, tmp.width, tmp.height);
			} else
			{
				btn.enable = false;
			}
		}
		// �O�̃y�[�W�փ{�^��
		if(sf.scenemode_page_num > 0)
		{
			.button(%[x:10,  y:420, graphic:"button_pager_prev", target:"*loadimage", exp:"sf.scenemode_page_num--", invalidDown:true]);
		}
		// ���̃y�[�W�փ{�^��
		if(sf.scenemode_page_num < tf.scenemode_page_num_max - 1)
		{
			.button(%[x:970, y:420, graphic:"button_pager_next", target:"*loadimage", exp:"sf.scenemode_page_num++", invalidDown:true]);
		}
	}
	// ���݂̃y�[�W���̕\��
	if(tf.scenemode_page_num_max > 1)
	{
		with(kag[sf.effection_page].base) {
			.font.height = 14;
			.drawText(480, 150, "PAGE" + (sf.scenemode_page_num + 1), 0xffffff, 255, true, 4096, 0xa22954, 2);
		}
	}

	// �f�o�b�O�R�[�h(��z�t���O�؂�ւ�)
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

;�E�N���b�N
@rclick call=false jump=true target="*rc" enabled=true

@s

;��z�փW�����v
*jump
;�x�𖳌�
@store enabled=false

@uall
@BGM_FO

;�^�C�g���t���O���I�t��
@eval exp="f.ftitle = false"
;�E�N���b�N�ݒ�T�u���[�`���Ăяo��
@rclick call=false jump=false enabled=true
;���b�Z�[�W����L��
@history enabled=true output=true
;���b�Z�[�W���C���[�ݒ�
@current layer=message0
@M_SET
@backlay

;@layopt layer=message0 page=back visible=true
;@layopt layer=message1 page=back visible=true
@M_FI
@eval exp="tf.scene_mode=true"
@jump storage=&tf.storage target=&tf.target

;��z����߂�
*return
@MPGSTOP cond="kag.movies[0].lastStatus!='unload'"
@videolayer channel=1 page=fore layer=base
@videolayer channel=2 page=back layer=base
@video loop=true visible=true mode="layer" width=1024 height=768
;�E�N���b�N����
@rclick call=false jump=false enabled=false
@uall
@BGM_FO
@eval exp="tf.scene_mode=false"
;�^�C�g���t���O���I����
@eval exp="f.ftitle = true"
;�I�[�g���[�h�L�����Z��
@cancelautomode
;�J�b�g�C���t���O�����낷
@eval exp="f.viewcutin=void"
@jump target="*scenemode"

;���܂��I����ʂɖ߂�
*rc
;�����N�����b�N
@locklink
;�E�N���b�N����
@rclick call=false jump=false enabled=false
@uall
@jump storage="extra.ks"
