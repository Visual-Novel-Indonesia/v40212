;おまけ
*extra
@rclick call=false jump=false storage=extra.ks enabled=false

@backlay
;背景読込
@lsg storage=extra
;ボタン読込
@current layer="messages0" page=&sf.effection_page
@position visible=true
@btn x=771 y=65 graphic="button_return_t" target="*ret"
@btn x=394 y=404 graphic=button_menu_gallery target=*gallery
@btn x=394 y=495 graphic=button_menu_scene target=*scene

;トランジション
@if exp="sf.effection"
@trans method=crossfade time=500
@wt
@endif

@rclick call=false jump=true enabled=true target=*ret
@s

*gallery
@rclick call=false jump=false enabled=false
@uall time=500
@jump storage="gallery.ks"

*scene
@rclick call=false jump=false enabled=false
@uall time=500
@jump storage="scenemode.ks"

*ret
@rclick call=false jump=false enabled=false
@uall time=500
@jump storage="title.ks" target="*title_menu"