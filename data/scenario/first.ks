;��`���X

;�}�N���ǂݍ���
@call storage="macro.ks"

;����N�����ۂ�
;-------------------------------------------------
@ignore exp="sf.first_boot"

;��ʌ��ʕϐ�������������
@eval exp="sf.effection = true"
@eval exp="sf.effection_page = 'back'"
;��z�p�ϐ�������
@eval exp="sf.recollect = []"
;���{�����[��������
@bgmopt gvolume=50
@seopt buf=0 gvolume=50
@seopt buf=1 gvolume=50
@seopt buf=2 gvolume=50
;�Z�[�u���[�h�̕\���y�[�W��������
@eval exp="sf.save_now_page = 0"
;���b�Z�[�W���C���[�̕s�����x
@eval exp="sf.msg_opacity = 153"
;�J�b�g�C���̕\���ݒ�
@eval exp="sf.cutin = true"

@eval exp="sf.first_boot = true"

@endignore
;-------------------------------------------------
;����N�����݂̂̐ݒ�I��

;�y�[�W���̃Z�[�u�ő吔
@eval exp="sf.save_max_page = 9"

;�t�F�[�h�����
@eval exp="sf.effection_time = 1000"

*start|�X�^�[�g
@wait time=500
@lbg storage="op01" time=5000
@lbg storage="white" time=1000
@lbg storage="op02" time=5000
@lbg storage="white" time=1000
@lbg storage="ippa" time=5000
@lbg storage="white" time=1000
@lbg
@jump storage="title.ks"
