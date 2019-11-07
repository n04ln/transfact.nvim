scriptencoding utf-8

if exists('g:loaded_transfact')
    finish
endif
let g:loaded_transfact = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:Requiretransfact(host) abort
  return jobstart(['transfact.nvim'], { 'rpc': v:true })
endfunction

call remote#host#Register('transfact.nvim', '0', function('s:Requiretransfact'))
call remote#host#RegisterPlugin('transfact.nvim', '0', [
\ {'type': 'function', 'name': 'Transfact', 'sync': 1, 'opts': {'nargs':'*'}},
\ ])

function! transfact#transfact_win_close() abort
  if exists('g:transfact_win')
    call nvim_win_close(g:transfact_win, v:true)
  endif
endfunction

" for auto close window when leave transfact window
autocmd WinLeave transfact :call transfact#transfact_win_close()
vnoremap <silent><C-t>e :call transfact#translate("en", "ja")<CR>
vnoremap <silent><C-t>j :call transfact#translate("ja", "en")<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
