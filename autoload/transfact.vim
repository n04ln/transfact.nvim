scriptencoding utf-8

if !exists('g:loaded_transfact')
    finish
endif
let g:loaded_transfact = 1

let s:save_cpo = &cpo
set cpo&vim

" TODO: Optimize it!
" let g:w = 75
let g:h = 20
let g:margin = 7

hi ActiveWindow guibg=#444444
hi InactiveWindow guibg=#0D1B22

function! transfact#trans(selected, src, dst) range
  " this function is written by Golang (see main.go)
  return Transfact(a:selected, a:src, a:dst)
endfunction

function! transfact#selected() range
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp

  let selected = substitute(selected, '\"', '\\"', 'g')
  let selected = substitute(selected, "`", "\\\\`", 'g')
  let selected = substitute(selected, "\n", " ", 'g')
  let selected = substitute(selected, "//", " ", 'g')

  return selected
endfunction

function! transfact#show_floating_win()
  let opt = {'relative': 'editor',
        \ 'width': nvim_win_get_width(0)-g:margin*2,
        \ 'height': g:h,
        \ 'row': g:margin,
        \ 'col': g:margin,
        \ 'anchor': 'NW',
        \ 'style': 'minimal'}
  if exists('g:transfact_buf')
    let w = nvim_open_win(g:transfact_buf, 0, opt)
    return w
  else
    " open floating window
    let g:transfact_buf = nvim_create_buf(v:false, v:true)
    let w = nvim_open_win(g:transfact_buf, 0, opt)
    return w
  endif
endfunction

function! transfact#translate(src, dst) range
  " to get text of visual selected
  let selected = transfact#selected()

  " show and checkout translation buffer
  let g:transfact_win = transfact#show_floating_win()
  let success = win_gotoid(g:transfact_win)
  if success == 0
    echo 'failed win_gotoid(' . win . ')'
    return
  endif

  " set option and change buffer name
  file transfact
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal filetype=transfact
  setlocal noswapfile
  setlocal nobuflisted
  setlocal undolevels=-1
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

  " overwrite content to buffer
  let text = transfact#trans(selected, a:src, a:dst)
  call nvim_buf_set_lines(g:transfact_buf, 0, -1, v:true, [" original:", selected, "", " after:", text])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
