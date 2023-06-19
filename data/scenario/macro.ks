;�}�N���Q

; �� ���C���[������
;-------------------------------------------------
@macro name="LAYFORMAT"

@eval exp="tf.layer_count = kag.fore.layers.count, tf.message_count = kag.fore.messages.count"
@laycount layers="0" messages="0"
@laycount layers="&tf.layer_count" messages="&tf.message_count"

@endmacro

; �� �w�i�t�F�C�h�C��
;-------------------------------------------------
@macro name="BG_FI"

@eval exp="mp.storage='bk_black'" cond="mp.storage===void || mp.storage=='black'"
@eval exp="mp.storage='bk_white'" cond="mp.storage=='white'"
@eval exp="mp.backlay=true" cond="mp.backlay===void"

@backlay cond="mp.backlay"
@eval exp="hideLayers(sf.effection_page);" cond="mp.hidelayers"
@image layer=base page=&sf.effection_page storage=%storage
@if exp="sf.effection"
@eval exp="mp.method='universal'" cond="mp.rule !== void"
@eval exp="mp.time=sf.effection_time" cond="mp.time===void"
@trans method=%method|crossfade time=%time rule=%rule vague=%vague stay=%stay
@wt canskip=%canskip
@endif

@endmacro

@macro name="lbg"
@BG_FI *
@endmacro

; �� �w�i�t�F�C�h�A�E�g
;-------------------------------------------------
@macro name="BG_FO"

@backlay
@freeimage layer=base page=&sf.effection_page
@if exp="sf.effection"
@eval exp="mp.method='universal'" cond="mp.rule !== void"
@eval exp="mp.time=sf.effection_time" cond="mp.time===void"
@trans method=%method|crossfade time=%time rule=%rule vague=%vague stay=%stay
@wt canskip=%canskip
@endif

@endmacro

@macro name="ubg"
@BG_FO *
@endmacro

; �� �C�x���gCG�t�F�C�h�C��
;-------------------------------------------------
@macro name="E_FI"
@eval exp="mp.backlay=true" cond="mp.backlay===void"
@eval exp="mp.trans=true" cond="mp.trans===void"

@backlay cond="mp.backlay"
@image layer=base page="&mp.trans ? sf.effection_page : 'fore'" storage=%storage
@if exp="sf.effection && mp.trans"
@eval exp="mp.time=sf.effection_time" cond="mp.time===void"
@trans method=%method time=%time rule=%rule|TR26 vague=%vague stay=%stay
@wt canskip=%canskip
@endif

@ignore exp="tf.scene_mode"
@eval exp="sf[mp.storage.substring(0,mp.storage.length - 1)]++" cond="!sf[mp.storage]"
@eval exp="sf[mp.storage]=true"
@endignore
@endmacro

@macro name="lcg"
@E_FI *
@endmacro

; �� �t���b�V��
;-------------------------------------------------
@macro name="FLASH"
@eval exp="tf.storage = kag.fore.base.Anim_loadParams.storage"
@if exp="mp.ftime=sf.effection_time\3" cond="mp.ftime===void"
@BG_FI storage="white" time=%ftime hidelayers=true
@wait time=200 cond="!sf.effection"
@eval exp="mp.time=sf.effection_time" cond="mp.time===void"
@eval exp="mp.storage = tf.storage" cond="mp.storage==void"
@eval exp="showLayers(sf.effection_page)"
@E_FI storage=%storage time=%time backlay=false
@endmacro

; �� �O�i���C���[�t�F�C�h�C��
;-------------------------------------------------
@macro name="F_FI"
@backlay
@eval exp="mp.pos='c'" cond="mp.pos===void && mp.left===void && mp.top===void"
@image layer=%layer|0 page=&sf.effection_page pos=%pos visible=true storage=%storage left=%left top=%top
@if exp="sf.effection"
@eval exp="mp.time=sf.effection_time\2" cond="mp.time===void"
@trans vague=0 rule=%rule|01 time=%time
@wt canskip=%canskip
@endif
@endmacro

@macro name="lfg"
@F_FI *
@endmacro

@macro name="FL_FI"
@eval exp="mp.layer=1"
@eval exp="mp.pos=l"
@F_FI *
@endmacro

@macro name="lfgl"
@FL_FI *
@endmacro

@macro name="FR_FI"
@eval exp="mp.layer=2"
@eval exp="mp.pos=r"
@F_FI *
@endmacro

@macro name="lfgr"
@FR_FI *
@endmacro

; �� �O�i���C���[�t�F�C�h�A�E�g
;-------------------------------------------------
@macro name="F_FO"
@backlay
@eval exp="hideLayers(sf.effection_page)" cond="mp.all"
@layopt layer=%layer|0 page=&sf.effection_page visible=false
@if exp="sf.effection"
@eval exp="mp.time=sf.effection_time\2" cond="mp.time===void"
@trans vague=0 rule=%rule|02 time=%time
@wt canskip=%canskip
@endif
@endmacro

@macro name="ufg"
@F_FO *
@endmacro

@macro name="FL_FO"
@eval exp="mp.layer=1"
@F_FO *
@endmacro

@macro name="ufgl"
@FL_FO *
@endmacro

@macro name="FR_FO"
@eval exp="mp.layer=2"
@F_FO *
@endmacro

@macro name="ufgr"
@FR_FO *
@endmacro

; �� �J�b�g�C��(�O�i���C���[)�t�F�C�h�C��
;-------------------------------------------------
@macro name="lci"
@eval exp="mp.layer='0'" cond="mp.layer===void"
@eval exp="f.viewcutin=%[storage:mp.storage, left:mp.left, top:mp.top, layer:mp.layer]"
@if exp="sf.cutin"
@backlay
@image layer=&mp.layer page=&sf.effection_page visible=true storage=%storage left=%left top=%top
@if exp="sf.effection"
@eval exp="mp.time=sf.effection_time\2" cond="mp.time===void"
@trans vague=0 rule=%rule time=%time cond="mp.rule!==void"
@trans method="crossfade" time=%time cond="mp.rule===void"
@wt canskip=%canskip
@endif
@endif
@endmacro

; �� �J�b�g�C��(�O�i���C���[)�t�F�C�h�A�E�g
;-------------------------------------------------
@macro name="uci"
@eval exp="mp.layer=f.viewcutin.layer;f.viewcutin=void"
@if exp="sf.cutin"
@backlay
@eval exp="hideLayers(sf.effection_page)" cond="mp.all"
@layopt layer=&mp.layer page=&sf.effection_page visible=false
@if exp="sf.effection"
@eval exp="mp.time=sf.effection_time\2" cond="mp.time===void"
@trans vague=0 rule=%rule time=%time cond="mp.rule!==void"
@trans method="crossfade" time=%time cond="mp.rule===void"
@wt canskip=%canskip
@endif
@endif
@endmacro

; �� ���b�Z�[�W���C���[�t�F�C�h�C��
;-------------------------------------------------
@macro name="M_FI"

@backlay
@layopt layer=message0 page=&sf.effection_page visible=true
@if exp="sf.effection && !sf.voiceMessageVisible"
@eval exp="mp.time=sf.effection_time\2" cond="mp.time===void"
@trans method=crossfade time=%time
@wt canskip=%canskip
@endif

@endmacro

; �� ���b�Z�[�W���C���[�t�F�C�h�A�E�g
;-------------------------------------------------
@macro name="M_FO"

@backlay
@eval exp="hideMessages(sf.effection_page)"
@if exp="sf.effection"
@eval exp="mp.time=sf.effection_time\2" cond="mp.time===void"
@trans method=crossfade time=%time
@wt canskip=%canskip
@endif

@endmacro

; �� �V�X�e���n�w�i�t�F�C�h�C��
;-------------------------------------------------
@macro name="lsg"
@eval exp="mp.layer = f.ftitle ? 'base' : (string)tf.layer_count"
@image layer=%layer page="&sf.effection_page" visible=true storage="back_base" cond="f.ftitle"
@image layer=%layer page="&sf.effection_page" visible=true storage="back_base_over" cond="!f.ftitle"
@pimage layer=%layer page="&sf.effection_page" storage="back_base_over" cond="f.ftitle"
@pimage layer=%layer page="&sf.effection_page" storage="&'back_' + mp.storage"
@endmacro

; �� �S���C���[�t�F�C�h�A�E�g
;-------------------------------------------------
@macro name="uall"

@backlay
@eval exp="hideLayers(sf.effection_page)"
@eval exp="hideMessages(sf.effection_page)"
@freeimage layer=base page=&sf.effection_page
@if exp="sf.effection"
@eval exp="mp.method='universal'" cond="mp.rule !== void"
@eval exp="mp.time=sf.effection_time" cond="mp.time===void"
@trans method=%method|crossfade time=%time rule=%rule vague=%vague stay=%stay
@wt canskip=%canskip
@endif

@endmacro

; �� ���b�Z�[�W���C���[�ݒ�
;-------------------------------------------------
@macro name="M_SET"
@layopt layer="message0" opacity="&sf.msg_opacity"
@position layer="message0" left="0" top="550" frame="window"
@position layer="message1" margint="51" marginl="128" marginr="&kag.fore.messages[0].defaultFontSize*2+77" left="0" top="563" 
@position layer="message2" margint="-4" marginl="-4" left="38" top="550" width="179" height="38"
@endmacro

; �� BGM�Đ�
;-------------------------------------------------
@macro name="BGM"
@playbgm storage="%storage" loop="%loop"
@endmacro

; �� BGM�t�F�C�h�C��
;-------------------------------------------------
@macro name="BGM_FI"
@fadeinbgm storage="%storage" loop="%loop" time="&int(kag.scflags.bgm.globalVolume/50)" cond="kag.scflags.bgm.globalVolume>0"
@playbgm storage="%storage" loop="%loop" cond="kag.scflags.bgm.globalVolume==0"
@endmacro

; �� BGM�t�F�C�h�A�E�g
;-------------------------------------------------
@macro name="BGM_FO"
;@wb canskip=true cond="kag.bgm.inFading"
@fadeoutbgm time="&int(kag.scflags.bgm.globalVolume/50)" cond="(kag.scflags.bgm.globalVolume > 0) && (kag.bgm.currentStorage!='')"
@stopbgm cond="kag.scflags.bgm.globalVolume==0"
@wb canskip="true"
@endmacro

; �� SE�Đ�
;-------------------------------------------------
@macro name="SE"
@playse buf="%buf|1" storage="%storage" cond="(kag.skipMode<3) && (kag.scflags.se[1].globalVolume>0)"
@ws canskip="true" buf="&mp.buf|1" cond="mp.wait"
@endmacro

; �� ���b�Z�[�W�E�B���h�E�̃V���[�g�J�b�g���j���[�p�}�N��
;-------------------------------------------------
@macro name="MENU"
@eval exp="kag.isMessageDisplay=false"
@eval exp="updateMenu()"
@locate x=806 y=77
@endmacro

; �� �V�i���I�p�}�N��
;-------------------------------------------------
@macro name="e"
@ignore exp="tf.isPlayVoice"
@MENU
@hr
@eval exp="kag.switchMessageLayerHiddenByUser()" cond="kag.messageLayerHiding"
@p
@ct cond="!mp.noct"
@layopt layer=message2 visible=false cond="!mp.noct"
@endignore

@if exp="tf.isPlayVoice"
@ve noct=%noct
@endif
@endmacro

; �� �{�C�X�����p�}�N��
;-------------------------------------------------
@macro name="ve"
@eval exp="tf.isPlayVoice=false"
@endhact

;�I�[�g���[�h�ŉ���������Ƃ������I���҂�(@p�����s���Ȃ�����)
@ws canskip=true cond="(kag.autoMode && kag.scflags.se[0].globalVolume>0) || sf.voiceMessageVisible"

@MENU
@eval exp="kag.switchMessageLayerHiddenByUser()" cond="!sf.voiceMessageVisible && kag.messageLayerHiding"
;�I�[�g���[�h�ŉ���������Ƃ����b�Z�[�W���������s(@p�����s���Ȃ�����)
@hr cond="(kag.autoMode && kag.scflags.se[0].globalVolume>0) || sf.voiceMessageVisible"
@hr
;�I�[�g���[�h�ŉ���������Ƃ��N���b�N�҂������Ȃ�(���������E�F�C�g�������Ȃ�)
@p cond="!(kag.autoMode && kag.scflags.se[0].globalVolume>0) && !sf.voiceMessageVisible"
@ct cond="!mp.noct"

@layopt layer=message2 visible=false cond="!mp.noct"

@endmacro

; �� ���b�Z�[�W�E�B���h�E�p�}�N��
;-------------------------------------------------
@macro name="name"
@ct
@layopt layer="message0" opacity="&sf.msg_opacity"

@eval exp="drawMenu()"

@eval exp="tf.isPlayVoice=false"

@if exp="mp.voice != void"
@PV storage="%voice"
@endif

@eval exp="kag.isMessageDisplay=true" cond="!sf.voiceMessageVisible || kag.se[0].status!='play'"
@layopt layer=message0 visible=true cond="!sf.voiceMessageVisible || kag.se[0].status!='play'"
@layopt layer=message1 visible=true cond="!sf.voiceMessageVisible || kag.se[0].status!='play'"
@layopt layer=message2 visible=false

@ignore exp="mp.chara=='�n' || mp.chara==void"
@current layer="message2"
@er
@layopt layer="message2" visible="true" cond="!sf.voiceMessageVisible || kag.se[0].status!='play'"
@style align="center"
@font size="&(int)(kag.fore.messages[2].width-10)/mp.chara.length" cond="kag.fore.messages[2].width-70<kag.fore.messages[2].font.getTextWidth(mp.chara)"
@ch text="&mp.chara"
@font size="default"
@endignore

@current layer="message1"
@endmacro

@macro name="msg"
@name *
@endmacro

@iscript
// ���b�Z�[�W�E�B���h�E�\�����\�b�h
function drawMenu() {
	kag.isMessageDisplay=false;
	var buttons = [
		["save",		"if(kag.inStable) kag.callExtraConductor('sub.ks','*save')",	tf.scene_mode],
		["load",		"if(kag.inStable) kag.callExtraConductor('sub.ks','*load')",	tf.scene_mode],
		["auto",		"if(kag.inStable) kag.switchAutoModeByKey()",									,	"kag.autoMode"],
		["skip",		"if(kag.inStable) kag.skipToNextStopByKey()",									,	"kag.skipMode >= 3"],
		["option",		"if(kag.inStable) kag.callExtraConductor('sub.ks','*option')"]
	];
	for(var i = 0; i < buttons.length; i++)
	{
		if(!buttons[i][2])
		{
			kag.tagHandlers.button(%[
				x:576 + i * 83, y:192,
				graphic:"window_menu_" + buttons[i][0],
				exp:buttons[i][1],
				invalidDown:true,
				flag:buttons[i][3]
			]);
		}
	}
}
// ���b�Z�[�W�E�B���h�E�ĕ`�惁�\�b�h
function updateMenu() {
	with(kag.current) {
		var n = .keyLink;
		if(n != -1)
		{
			var button = .links[n].object;
			if(button.type == .ltButton)
			{
				if(button.cursor == crDefault) button.cursor = kag.cursorPointed;
				button.Butt_mouseOn = true;
				button.draw();
			}
		}
	}
}
@endscript

; �� �I����
;-------------------------------------------------
@macro name="SELECT"

@e noct=true

@current layer="message0"
@eval exp="drawMenu()"

@current layer="message3"
@layopt layer="message" visible="true"
@eval exp="selChoice()"
@s
@endmacro

@iscript
//�I�����\�����\�b�h
function selChoice()
{
	// �{�^���摜�ݒ�	
	var linkCount = 0;
	while((mp["target" + (linkCount + 1)] != void || mp["storage" + (linkCount + 1)] != void)
			&& mp["text" + (linkCount + 1)] != void)
		linkCount++;

	// ���b�Z�[�W�����ɕ`��
	if(kag.historyWriteEnabled) {
		kag.historyLayer.reline();
		kag.historyLayer.store("�y�I�����z");
	}

	for(var i = 1; i <= linkCount; i++) {
		// �ΏۃV�i���I��
		var storage = void;
		if(mp["storage" + i] !== void)
			storage = mp["storage" + i];
		else
			storage = kag.conductor.curStorage;
		// �Ώۃ��x����
		var label = void;
		if(mp["target" + i] !== void)
			label = mp["target" + i];
		else
			label = kag.conductor.curLabel;
		// ���ǃt���O
		var isTrailFlag = sf["trail_" + Storages.chopStorageExt(Storages.extractStorageName(storage)) + "_" + label.substr(1)];
		// �I����������
		var text = mp["text" + i];
		// �I�������stjs��
		var exp = "kag.tagHandlers.layopt(%[layer:'message3', visible:false]);
					if(kag.historyWriteEnabled) {
						kag.historyLayer.reline();
						kag.historyLayer.store(\"��" + i + "�F" + text + "\");
						kag.historyLayer.reline();
						kag.historyLayer.reline();
					}";
		// �\��y���W
		var y = i * kag.fore.messages[0].top \ (linkCount + 1);

		// ���b�Z�[�W�����ɕ`��
		if(kag.historyWriteEnabled) {
			kag.historyLayer.reline();
			kag.historyLayer.store(i + "�F" + text);
		}

		if(isTrailFlag && (!tf.scene_mode || mp.scene_enable)) {
			// �{�҂Ńt���O����
			kag.tagHandlers.button(%[
				y:y, x:"c",
				graphic:"window_select",
				storage:mp["storage" + i],
				target:mp["target" + i],
				text:text,
				textColor:0xaaaaaa,
				exp:exp
			]);
		} else if(!isTrailFlag && tf.scene_mode && !mp.scene_enable) {
			// �V�[�����[�h�Ńt���O�Ȃ�
			kag.tagHandlers.button(%[
				y:y, x:"c",
				graphic:"window_select",
				text:text,
				textColor:0xffaaaa,
				opacity:150,
				hint:"�{�҂Ō��Ă��Ȃ����߁A�I�����邱�Ƃ��o���܂���"
			]);
		} else {
			// �{�҂Ńt���O�Ȃ��E�V�[�����[�h�Ńt���O����
			kag.tagHandlers.button(%[
				y:y, x:"c",
				graphic:"window_select",
				storage:mp["storage" + i],
				target:mp["target" + i],
				text:text,
				exp:exp
			]);
		}
	}
}
@endscript

; �� ��ʗh�炵
;-------------------------------------------------
@macro name="XYQUAKE"
@if exp="mp.time=sf.effection_time\3" cond="mp.time===void"
@quake vmax=%vmax hmax=%hmax time=%time
@endmacro

; �� ��ʗh�炵(�c�h��)
;-------------------------------------------------
@macro name="YQUAKE"
@XYQUAKE vmax=%max hmax=0 time=%time
@endmacro

; �� ��ʗh�炵(���h��)
;-------------------------------------------------
@macro name="XQUAKE"
@XYQUAKE vmax=0 hmax=%max time=%time
@endmacro

; �� �{�C�X�Đ��p�}�N��
;-------------------------------------------------
@macro name="PV"

@if exp="sf.voiceMessageVisible"
@nowait
@layopt layer=message0 visible=false
@layopt layer=message1 visible=false
@endif

@hact exp="&hactElement(mp.storage)"
@playse buf=0 storage=%storage cond="kag.skipMode<3 && kag.scflags.se[0].globalVolume>0"
@eval exp="tf.isPlayVoice=true"
@endmacro

; �� mpeg���[�r�[�p�}�N��
;-------------------------------------------------
@macro name="MOVIE"
@video loop=%loop visible=true width=1024 height=768
@playvideo storage=%storage
@wait time=1000 canskip=false
@wv canskip=true
@endmacro

; �� mpeg���[�r�[�p�}�N��(���C���[�Đ�)
;-------------------------------------------------
@macro name="MPG"
@eval exp="mp.loop=true" cond="mp.loop===void"
@video loop=%loop
@playvideo storage=%storage
@wv cond="!mp.loop"
@endmacro

; �� mpeg���[�r�[�Đ���~�p�}�N��(���C���[�Đ�)
;-------------------------------------------------
@macro name="MPGSTOP"
@stopvideo
@endmacro

; �� mpeg���[�r�[�I�v�V����
;-------------------------------------------------
@macro name="MPGOPT"
@video playrate=%speed
@endmacro


; �� �A�j���p
;-------------------------------------------------
@macro name="ANIME"
@if exp="sf.anime"
@eval exp="f.frameSpeed=1" cond="mp.speed===void"
@eval exp="f.frameStart=1" cond="mp.start===void"
@eval exp="f.framePerSec=30" cond="mp.fps===void"
@eval exp="f.frameLoop=true" cond="mp.loop===void"
@eval exp="f.frameRandom=void" cond="mp.random===void"
@eval exp="f.frameCount = f.frameStart - 1"
@ANIMEOPT *
@image storage=%storage page=fore layer=0 left=0 top=0 visible=true mode=rect clipleft="&kag.innerWidth * f.frameCount" cliptop=0 clipwidth="&kag.innerWidth" clipheight="&kag.innerHeight"
@endif
@endmacro

@macro name="ANIMEOPT"
@eval exp="f.frameSpeed=mp.speed,f.frameRandom=void" cond="mp.speed!==void"
@eval exp="f.frameStart=mp.start" cond="mp.start!==void"
@eval exp="f.frameEnd=mp.end" cond="mp.end!==void"
@eval exp="f.framePerSec=mp.fps" cond="mp.fps!==void"
@eval exp="f.frameLoop=mp.loop" cond="mp.loop!==void"
@eval exp="f.frameRandom=mp.random.split(',')" cond="mp.random!==void"
@animstart layer=0 cond="mp.loop"
@endmacro

; �� �X�^�b�t���[���p
;-------------------------------------------------
@macro name="STAFF_ROLL_SET"
@eval exp="tf.i=0"
@eval exp="kag.leftClickHook.add(cancelStaffRoll)" cond="mp.clickskip"
@eval exp="tf.staff_roll_fi_time=mp.fitime"
@eval exp="tf.staff_roll_wait_time=mp.wtime"
@eval exp="tf.staff_roll_fo_time=mp.fotime"
@eval exp="tf.staff_roll_loop_target=mp.target"
@eval exp="mp.color=0x00ffffff" cond="mp.fostorage=='white'"
@eval exp="mp.color=0x00000000" cond="mp.fostorage=='black' || mp.fostorage===void"
@eval exp="tf.staff_roll_fo_storage=mp.fostorage" cond="mp.color===void"
@eval exp="tf.staff_roll_fo_color=mp.color"
@eval exp="tf.staff_roll_loop=true"
@endmacro

@macro name="STAFF_ROLL"
@eval exp="tf.storage=mp.storages.split(',')"
@if exp="tf.i<tf.storage.count"
@image storage="&tf.storage[tf.i]" layer="base" page="back" cond="tf.staff_roll_loop"
@trans method="crossfade" time="&tf.staff_roll_fi_time" cond="tf.staff_roll_loop"
@wt canskip="false" cond="tf.staff_roll_loop"
@wait canskip="false" time="&tf.staff_roll_wait_time" cond="tf.staff_roll_loop"
@image storage="&tf.staff_roll_fo_storage" layer="base" page="back" cond="tf.staff_roll_loop" cond="tf.staff_roll_fo_color===void"
@eval exp="kag.back.base.fillRect(0, 0, kag.innerWidth, kag.innerHeight, tf.staff_roll_fo_color)" cond="tf.staff_roll_fo_color!==void"
@trans method="crossfade" time="&tf.staff_roll_fo_time" cond="tf.staff_roll_loop"
@wt canskip="false" cond="tf.staff_roll_loop"
@eval exp="tf.i++"
@jump target="&tf.staff_roll_loop_target" cond="tf.staff_roll_loop_target!=void"
@endif

@endmacro

; �� ��z�J�n
;-------------------------------------------------
@macro name="MEM_ST"
@eval exp="f.recollectNumber=mp.num"
@eval exp="f.recollectLabel=kag.currentLabel"
@endmacro

; �� ��z�I��
;-------------------------------------------------
@macro name="MEM_EN"
@jump storage="scene.ks" target="*return" cond="tf.scene_mode"
@eval exp="sf.recollect[f.recollectNumber] = f.recollectLabel" cond="f.recollectNumber !== void"
@eval exp="f.recollectNumber = void"
@endmacro

; �� �{�^��
;-------------------------------------------------
@macro name="btn"
@eval exp="mp.invalidDown=true"
@button *
@endmacro

; �� �V�X�e���{�^��
;-------------------------------------------------
@macro name="sbtn"
@eval exp="mp.invalidDown=true"
@eval exp="mp.invalidOn=true"
@button *
@endmacro


; �� �n�[�g�}�N����`
;-------------------------------------------------
@macro name="heart"
@graph storage="heart" char="false" alt="(�́[��)"
@endmacro

@return
