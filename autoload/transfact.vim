scriptencoding utf-8

if exists('g:loaded_transfact')
    finish
endif
let g:loaded_transfact = 1

let s:save_cpo = &cpo
set cpo&vim

function! transfact#selected()
    " to copy visual selected word
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp
  return selected
endfunction

function! transfact#translate()
  let selected = call transfact#selected()
  call Trans(selected)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
