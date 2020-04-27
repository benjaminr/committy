" Vim global plugin for auto-committing Python comments.
" Last change:   27 04 2020
" Maintainer:    Benjamin Rowell <brrowell@gmail.com>
" License:       This file is placed in the public domain.

if exists("g:loaded_committy")
        finish
endif
let g:loaded_committy = 1

function! CommentCommit()
  " Multiple language support through use of comment_sym
  let lang_comment_syms = {'py': '# ',
                          \'rb': '#',
                          \'php': '#',
                          \'pl': '#',
                          \'c': '//',
                          \'cpp': '//',
                          \'hpp': '//',
                          \'go': '//',
                          \'swift': '//',
                          \'js': '//',
                          \'java': '//',
                          \'class': '//',
                          \'vim': '"'}
  " Goto top
  normal! gg
  " Get the extension to look up comment sym
  let comment_sym = escape(get(lang_comment_syms, expand('%:e')), '/')
  " Search for commit comment
  let commit_line = search('^\s*' . comment_sym . '@')
  " If a commit is present
  if commit_line != 0
        " Get the single line comment
        let commit_msg = getline(commit_line)
        " Reformat as SLC with no @
        let commit_msg = substitute(commit_msg, comment_sym . '@', comment_sym, '')
        " Replace the line
        call setline(commit_line, commit_msg)
        " Write the buffer changes to the file
        write
        " Remove # from commit msg
        let commit_msg = substitute(commit_msg, '^\s*' . comment_sym . '\s*', '', '')
        " Add file to git stage
        call system('git add ' . expand('%'))
        " Commit changes
        call system('git commit -m "' . commit_msg . '"')
  endif
endfunction

autocmd BufWritePre * call CommentCommit()
autocmd FileWritePre * call CommentCommit()
