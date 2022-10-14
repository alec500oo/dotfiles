" ftplugin/python.vim

let b:ale_linters = ['flake8']
let b:ale_fixers = ['yapf']

nnoremap <buffer> <leader>f <Plug>(ale_fix)
