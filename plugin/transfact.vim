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
\ {'type': 'function', 'name': 'InitializeTransfact', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'Trans', 'sync': 1, 'opts': {}},
\ ])

" for initialize
call InitializeTransfact()

vnoremap <C-u>tr :call transfact#open_floating_window()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
