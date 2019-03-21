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

function! transfact#open_floating_window()
  let bufnr = bufnr('%')
  let winnr = winbufnr(bufnr)
  let wh = winheight(winnr)
  let ww = winwidth(winnr)
  let margin = 7

  if exists('g:transfact_buf')
    call nvim_open_win(g:transfact_buf, v:true, 200, 20, {'relative': 'editor', 'row': 7, 'col': 7})
  else
    " open floating window
    call nvim_open_win(bufnr, v:true, 200, 20, {'relative': 'editor', 'row': 7, 'col': 7})
    enew
	  set buftype=nofile
	  set bufhidden=hide
	  setlocal noswapfile
	  setlocal nobuflisted
    set undolevels=-1
    let g:transfact = bufnr('%')
  endif
  
  execute ":b" . g:transfact_buf
  execute "0," . line("$") . "delete"

  let text = transfact#translate()
  " execute ":normal i" . text
  append('.', text)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
