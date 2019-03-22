scriptencoding utf-8

if !exists('g:loaded_transfact')
    finish
endif
let g:loaded_transfact = 1

let s:save_cpo = &cpo
set cpo&vim

function! transfact#translate(selected) range
  return Trans(a:selected)
endfunction

function! transfact#open_floating_window() range
  " to get text of visual selected
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp

  let selected = substitute(selected, '\"', '\\"', 'g')
  let selected = substitute(selected, "\'", "\\'", 'g')
  let selected = substitute(selected, "\n", " ", 'g')
  let selected = substitute(selected, " // ", " ", 'g')
  let cmd = 'echo "' . selected . "\" | perl -pe 's/^ *\\/\\/(.*)$/$1/g;'"
  let selected = system(cmd)

  " to open floating window
  let bufnr = bufnr('%')
  let winnr = winbufnr(bufnr)
  if exists('g:transfact_buf')
    call nvim_open_win(g:transfact_buf, v:true, 200, 20, {'relative': 'editor', 'row': 7, 'col': 7})
  else
    " open floating window
    call nvim_open_win(bufnr, v:true, 200, 20, {'relative': 'editor', 'row': 7, 'col': 7})
    enew
    let g:transfact_buf = bufnr('%')
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal undolevels=-1
    " setlocal modifiable=off
  endif
  
  " checkout translation buffer
  execute ":b" . g:transfact_buf

  " delete floating window buffer
  let tmp = @@
  execute "0," . line("$") . "delete"
  let @@ = tmp

  " write to translation buffer
  let text = transfact#translate(selected)
  call append('$', '*** original')
  call append('$', selected)
  call append('$', '')
  call append('$', '*** translated')
  call append('$', text)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
