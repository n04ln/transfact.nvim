scriptencoding utf-8

if !exists('g:loaded_transfact')
    finish
endif
let g:loaded_transfact = 1

let s:save_cpo = &cpo
set cpo&vim

hi ActiveWindow guibg=#111111
hi InactiveWindow guibg=#0D1B22

function! transfact#trans(selected) range
  return Trans(a:selected)
endfunction

function! transfact#selected() range
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp

  return selected
endfunction

function! transfact#remove_unncessary_chars(selected)
  let selected = a:selected
  " let selected = substitute(selected, '\"', '\\"', 'g')
  " let selected = substitute(selected, "`", "\\\\`", 'g')
  " let selected = substitute(selected, "\n", " ", 'g')
  " let selected = substitute(selected, "//", " ", 'g')
  return selected
endfunction

function! transfact#shape_selected_string(selected)
  let selected = transfact#remove_unncessary_chars(a:selected)
  return selected
endfunction

function! transfact#show_floating_win()
  let w = 100
  let h = 20
  let margin = 7
  let bufnr = bufnr('%')
  if exists('g:transfact_buf')
    call nvim_open_win(g:transfact_buf, v:true, w, h, {'relative': 'editor', 'row': margin, 'col': margin})
    return g:transfact_buf
  else
    " open floating window
    call nvim_open_win(bufnr, v:true, w, h, {'relative': 'editor', 'row': margin, 'col': margin})
    enew
    let g:transfact_buf = bufnr('%')
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal undolevels=-1
    setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    return g:transfact_buf
  endif
endfunction

function! transfact#modify_current_buffer(selected, text)
  " to editable
  setlocal modifiable

  " delete floating window buffer
  let tmp = @@
  execute "0," . line("$") . "delete"
  let @@ = tmp

  " write to translation buffer
  call append('$', '*** original')
  call append('$', a:selected)
  call append('$', '')
  call append('$', '*** translated')
  call append('$', a:text)

  " delete blank line on the top
  let tmp = @@
  execute "0" . "delete"
  let @@ = tmp

  " to NOT editable
  setlocal nomodifiable
endfunction

function! transfact#translate() range
  " to get text of visual selected
  let selected = transfact#selected()

  " NOTE: only remove // comment...
  let selected = transfact#shape_selected_string(selected)

  " show and checkout translation buffer
  let g:transfact_buf = transfact#show_floating_win()
  execute ":b" . g:transfact_buf

  " overwrite content to buffer
  let text = transfact#trans(selected)
  call transfact#modify_current_buffer(selected, text)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
