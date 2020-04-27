" Vim global plugin for auto-committing Python comments.
" Last change:   27 04 2020
" Maintainer:    Benjamin Rowell <brrowell@gmail.com>
" License:       This file is placed in the public domain.

if exists("g:loaded_committy")
	finish
endif
let g:loaded_committy = 1

function! CommentCommit()
  " Goto top   
  normal! gg
  " Search for commit comment
  let commit_line = search('^#@')
  " If a commit is present
  if commit_line != 0
	echom commit_line
	" Get the single line comment
  	let commit_msg = getline(commit_line)
	" Reformat as SLC with no @
  	let commit_msg = substitute(commit_msg, '#@', '#', '')
	" Replace the line
  	call setline(commit_line, commit_msg)
	" Remove # from commit msg 
  	let commit_msg = substitute(commit_msg, '^#\s*', '', '')
  	" Add file to git stage
	call system('git add ' . expand('%'))
	" Commit changes
  	call system('git commit -m "' . commit_msg . '"')
  endif
endfunction

autocmd BufWritePre *.py call CommentCommit()
