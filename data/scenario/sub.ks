;--------------------------------------------------
; �� �Z�[�u���[�h
;--------------------------------------------------
*save
@locklink
@locksnapshot
;���b�Z�[�W���𖳌��B�o�͂�����
@history enabled=false output=false
;�E�N���b�N����
@rclick call=false jump=false enabled=false
;���̃��[�`���ɓ������Ƃ��ɂ����g�����W�V�������s��
@eval exp="tf.trans_first=true"
;���݂̃��C���[����ۑ����ă��C���[��ǉ�
@eval exp="tf.layer_count=kag.fore.layers.count"
@eval exp="tf.message_count=kag.fore.messages.count"
@laycount layers=&tf.layer_count+2 messages=&tf.message_count+1
;����ʂɃR�s�[
@backlay
;���b�Z�[�W���C���[��\����
@eval exp="hideMessages(sf.effection_page)"
;�w�i�摜�̓ǂݍ���
@lsg storage=save
;�T���l�C���y�[�W�ݒ�
@eval exp="tf.effection_page_this = sf.effection_page"

*savemenu
@eval exp="tf.effection_page_this = 'back'" cond="tf.trans_pager !== void && sf.effection"
@current layer="&'message' + tf.message_count" page=&tf.effection_page_this
@position visible=true
@eval exp="drawSaveLoad('save')"

;��ʈڍs���̃g�����W�V����
@if exp="tf.trans_first && sf.effection"
@trans method=crossfade time=500
@wt
@endif
;�y�[�W���[�̃g�����W�V����
@if exp="tf.trans_pager !== void && sf.effection"
@trans method="scroll" stay="stayfore" time=500 cond="tf.trans_pager=='prev'"
@trans method="scroll" stay="stayback" time=500 cond="tf.trans_pager=='next'"
@wt
@endif
;�T�u���[�`�����E�N���b�N
@rclick call=false jump=true storage="sub.ks" target="*ret" enabled=true
;�t���O�ݒ�
@eval exp="tf.trans_pager = void"
@eval exp="tf.trans_first = false"
@eval exp="tf.effection_page_this = 'fore'"

@s

*saveaction
@eval exp="tf.result = kag.saveBookMarkWithAsk(tf.save_num)"
;�Ō�ɕۑ������Z�[�uNo��ۑ�
@eval exp="sf.save_last_data = tf.save_num" cond="tf.result"
@jump target=*savemenu

;--------------------------------------------------
; �� ���[�h���[�h
;--------------------------------------------------
*load
@locklink
@locksnapshot cond="!f.ftitle"
;���b�Z�[�W���𖳌��B�o�͂�����
@history enabled=false output=false
;�E�N���b�N����
@rclick call=false jump=false enabled=false
;���̃��[�`���ɓ������Ƃ��ɂ����g�����W�V�������s��
@eval exp="tf.trans_first=true"
;���݂̃��C���[����ۑ����ă��C���[��ǉ�
@eval exp="tf.layer_count=kag.fore.layers.count"
@eval exp="tf.message_count=kag.fore.messages.count"
@laycount layers=&tf.layer_count+2 messages=&tf.message_count+1
;����ʂɃR�s�[
@backlay
;���b�Z�[�W���C���[��\����
@eval exp="hideMessages(sf.effection_page)"
;�w�i�摜�̓ǂݍ���
@lsg storage=load
;�T���l�C���y�[�W�ݒ�
@eval exp="tf.effection_page_this = sf.effection_page"


*loadmenu
@eval exp="tf.effection_page_this = 'back'" cond="tf.trans_pager !== void && sf.effection"
@current layer="&'message' + tf.message_count" page=&tf.effection_page_this
@position visible=true
@eval exp="drawSaveLoad('load')"

;��ʈڍs���̃g�����W�V����
@if exp="tf.trans_first && sf.effection"
@trans method="crossfade" time="500"
@wt
@endif
;�y�[�W���[�̃g�����W�V����
@if exp="tf.trans_pager != void && sf.effection"
@trans method="scroll" stay="stayfore" time="500" cond="tf.trans_pager=='prev'"
@trans method="scroll" stay="stayback" time="500" cond="tf.trans_pager=='next'"
@wt
@endif
;�T�u���[�`�����E�N���b�N
@rclick call=false jump=true storage="sub.ks" target="*ret" enabled=true
@rclick call=false jump=true storage="sub.ks" target="*ret_title" enabled=true cond="f.ftitle"
;�t���O�ݒ�
@eval exp="tf.trans_pager = void"
@eval exp="tf.trans_first = false"
@eval exp="tf.effection_page_this = 'fore'"

@s

*loadaction
@load place="&tf.save_num" ask="true"
@jump target="*loadmenu"

;--------------------------------------------------
; �� ���ݒ胂�[�h
;--------------------------------------------------
*option
@locklink
@locksnapshot cond="!f.ftitle && !tf.scene_mode"
;���b�Z�[�W���𖳌��B�o�͂�����
@history enabled=false output=false
;�E�N���b�N����
@rclick call=false jump=false enabled=false
;���̃��[�`���ɓ������Ƃ��ɂ����g�����W�V�������s��
@eval exp="tf.trans_first=true"
;���݂̃��C���[����ۑ����ă��C���[��ǉ�
@eval exp="tf.layer_count=kag.fore.layers.count"
@eval exp="tf.message_count=kag.fore.messages.count"
@laycount layers=&tf.layer_count+2 messages=&tf.message_count+1
;����ʂɃR�s�[
@backlay
;���b�Z�[�W���C���[��\����
@eval exp="hideMessages(sf.effection_page)"
;�w�i�摜�̓ǂݍ���
@lsg storage=option
;�T���l�C���y�[�W�ݒ�
@eval exp="tf.effection_page_this = sf.effection_page"

*optionmenu
@current layer="&'message' + tf.message_count" page=&tf.effection_page_this
@position visible=true
@btn x=771 y=12 graphic="button_return_t" target="*ret_title" cond="!tf.scene_mode"
@btn x=771 y=12 graphic="button_return_s" target="*ret_title" cond="tf.scene_mode"
@btn x=771 y=65 graphic="button_return_g" target="*ret" cond="!f.ftitle"

@iscript
{
	sf.tempVolumes = [] if sf.tempVolumes === void;
	with(kag.tagHandlers) {
		var width=56;
		var x = 600, y = 160, addY = 115;
		var n = 100000 \ 5;
		var vols = [kag.scflags.se[0], kag.scflags.se[1], kag.scflags.bgm];
		var imgOn = "button_on", imgOff = "button_off", imgVol = "button_vol";
		var target = "*optionmenu";
		for(var i = 0; i < vols.count; i++) {
			var opt = i == 2 ? "bgmopt(%[" : "seopt(%[buf:" + i + ", ";
			for(var j = 0; j < 5 ; j++){
				// volume�{�^��
				.button(%[
					x:j * width + x, y:i * addY + y, graphic:imgVol + (j + 1), target:target,
					invalidDown:true, invalidOn:true, flag:vols[i].globalVolume >= (j + 1) * n,
					exp:"kag.tagHandlers." + opt + "gvolume:" + (j + 1) * (n \ 1000) + "]);"
				]);
			}
			// on�{�^��
			.button(%[
				x:265, y:i * addY + y + 45, graphic:imgOn, target:target,
				invalidDown:true, invalidOn:true, flag:vols[i].globalVolume > 0,
				exp:"if (" + (vols[i].globalVolume == 0) + ") {"
					+ "kag.tagHandlers." + opt + "gvolume:sf.tempVolumes[" + i + "]]); "
					+ "}"
			]);
			// off�{�^��
			.button(%[
				x:362, y:i * addY + y + 45, graphic:imgOff, target:target,
				invalidDown:true, invalidOn:true, flag:vols[i].globalVolume == 0,
				exp:"if (" + (vols[i].globalVolume > 0) + ") { "
					+ "sf.tempVolumes[" + i + "] = " + vols[i].globalVolume \ 1000 + "; "
					+ "kag.tagHandlers." + opt + "gvolume:0]); "
					+ (i == 0 ? "sf.voiceMessageVisible = false;" : "")
					+ "}"
			]);
		}
		// ��ʌ���
		.button(%[
			x:265, y:553, graphic:imgOn, target:target,
			invalidDown:true, invalidOn:true, flag:sf.effection,
			exp:"sf.effection = true; sf.effection_page = 'back'"
		]);
		.button(%[
			x:362, y:553, graphic:imgOff, target:target,
			invalidDown:true, invalidOn:true, flag:!sf.effection,
			exp:"sf.effection = false; sf.effection_page = 'fore'"
		]);
		// ���ǃX�L�b�v
		.button(%[
			x:265, y:672, graphic:"button_skip_read", target:target,
			invalidDown:true, invalidOn:true, flag:!sf.skip_read,
			exp:"sf.skip_read = false"
		]);
		.button(%[
			x:362, y:672, graphic:"button_skip_unread", target:target,
			invalidDown:true, invalidOn:true, flag:sf.skip_read !== void && sf.skip_read,
			exp:"sf.skip_read = true"
		]);
		// �{�C�X�Đ����E�B���h�E
		.image(%[
			left:483, top:502, layer:(string)(tf.layer_count + 1), page:tf.effection_page_this, visible:true,
			storage:"option_visible", opacity:kag.scflags.se[0].globalVolume == 0 ? 125 : 255
		]);
		if(sf.voiceMessageVisible === void)
			sf.voiceMessageVisible = false;
		if(kag.scflags.se[0].globalVolume > 0) {
			.button(%[
				x:599, y:553, graphic:imgOn, target:target,
				invalidDown:true, invalidOn:true, flag:sf.voiceMessageVisible,
				exp:"sf.voiceMessageVisible = true"
			]);
			.button(%[
				x:696, y:553, graphic:imgOff, target:target,
				invalidDown:true, invalidOn:true, flag:!sf.voiceMessageVisible,
				exp:"sf.voiceMessageVisible = false"
			]);
		}
		// �����x�ύX
		.slider(%[
			x:621, y:637, width:300, height:35,
			min:51, max:255, graphic:"toumeido_Dial",
			position:+sf.msg_opacity, target:"sf.msg_opacity"
		]);
		// �J�b�g�C��
		.button(%[
			x:538, y:90, graphic:imgOn, target:target,
			invalidDown:true, invalidOn:true, flag:sf.cutin,
			exp:"sf.cutin = true; if(f.viewcutin) { kag.tagHandlers.image(%[layer:f.viewcutin.layer, storage:f.viewcutin.storage, left:f.viewcutin.left, top:f.viewcutin.top, visible:true]); kag.tagHandlers.backlay(%[layer:f.viewcutin.layer]); }"
		]);
		.button(%[
			x:635, y:90, graphic:imgOff, target:target,
			invalidDown:true, invalidOn:true, flag:!sf.cutin,
			exp:"sf.cutin = false; if(f.viewcutin) { kag.fore.layers[f.viewcutin.layer].visible = false; kag.tagHandlers.backlay(%[layer:f.viewcutin.layer]); }"
		]);
	}
}
@endscript

;��ʈڍs���̃g�����W�V����
@if exp="tf.trans_first && sf.effection"
@trans method=crossfade time=500
@wt
@endif
;�T�u���[�`�����E�N���b�N
@rclick call=false jump=true storage="sub.ks" target="*ret" enabled=true
@rclick call=false jump=true storage="sub.ks" target="*ret_title" enabled=true cond="f.ftitle"
;�t���O�ݒ�
@eval exp="tf.trans_first=false"
@eval exp="tf.effection_page_this='fore'"

@s

*history
; �� ���b�Z�[�W����
@showhistory
@return

*hide
; �� ��������
@hidemessage
@wait time=200
@return

*ret
; �T�u���[�`������߂�

;�E�N���b�N������
@rclick call=false jump=false enabled=false

@if exp="sf.effection"
@freeimage layer=&tf.layer_count page=back
@freeimage layer=&tf.layer_count+1 page=back
@eval exp="showMessages(sf.effection_page)"
@layopt layer="&'message' + tf.message_count" visible=false page=back
@trans method=crossfade time=500
@wt
@endif

@if exp="!sf.effection"
@eval exp="showMessages(sf.effection_page)"
@layopt layer="&'message' + tf.message_count" visible=false
@endif

;�E�N���b�N�L��(���b�Z�[�W����)
@rclick call=false jump=false enabled=true
;���C���[�������ɂ��ǂ�
@laycount layers=&tf.layer_count messages=&tf.message_count
;���b�Z�[�W���C���[��\��
;���b�Z�[�W����L��
@history enabled=true output=true
;�X�i�b�v�V���b�g�L��
@unlocksnapshot cond="!f.ftitle && !tf.scene_mode"
;�}�E�X�J�[�\���X�e�[�^�X��������
@eval exp="kag.mouseCursorState=0"
@return

*ret_title
;�^�C�g�����痈�Ă���ꍇ
@if exp="f.ftitle"
@eval exp="f.ftitle=false"

@uall

@laycount layers=&tf.layer_count messages=&tf.message_count
@jump storage="title.ks" target="*title_menu"

@endif


;�Q�[�����̏ꍇ
;�V�[�����[�h�łȂ��ꍇ
@gotostart ask=true cond="!tf.scene_mode"
;�V�[�����[�h�̏ꍇ
@if exp="tf.scene_mode"
@eval exp="tf.result = askYesNo('��z�V�[���I����ʂɖ߂�܂��B��낵���ł��� ?')"
@return storage="scenemode.ks" target="*return" cond="tf.result"
@endif

@unlocklink

@s

*title_sub
;�V�[�����[�h�łȂ��ꍇ
@gotostart ask=true cond="!tf.scene_mode"
;�V�[�����[�h�̏ꍇ
@if exp="tf.scene_mode"
@eval exp="tf.result = askYesNo('��z�V�[���I����ʂɖ߂�܂��B��낵���ł��� ?')"
@return storage="scenemode.ks" target="*return" cond="tf.result"
@endif

@return