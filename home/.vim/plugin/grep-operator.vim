nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
	let saved_unnamed_reg = @@

	if a:type ==# 'v'
		normal! `<v`>y
	elseif a:type ==# 'char'
		normal! `[y`]
	else
		return
	endif
	
	silent execute "grep! -R "
		\ . shellescape(@@)
		\ . " ."
	copen
	redraw!

	let @@ = saved_unnamed_reg
endfunction
