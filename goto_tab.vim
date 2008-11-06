" GotoTab
" Find the tab with the openned buffer. If can't find one, open a new tab.

function! GotoTab(name)
    if bufloaded(a:name)
	let buf_nbr = bufnr(a:name)
	let tab_nbr = -1
	let win_nbr = -1
	for i in range(1, tabpagenr('$'))
	    let tab_windows = tabpagebuflist(i)
	    if count(tab_windows, buf_nbr) == 1
		let win_nbr = index(tab_windows, buf_nbr)
		let tab_nbr = i
		break
	    endif
	endfor
	exe 'tabn ' . tab_nbr
	exe 'wincmd t'
	if win_nbr != -1
	    exe (win_nbr + 1) . 'wincmd w'
	endif
    else
	exe 'tabe ' . a:name
    endif
endfun

comm! -nargs=1 -complete=file GotoTab :call GotoTab('<args>')
