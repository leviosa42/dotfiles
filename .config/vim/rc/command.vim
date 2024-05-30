" https://zenn.dev/vim_jp/articles/show-hlgroup-under-cursor
function ShowHighlightGroup()
  let hlgroup = synIDattr(synID(line('.'), col('.'), 1), 'name')
  let groupChain = []

  while hlgroup !=# ''
    call add(groupChain, hlgroup)
    let hlgroup = matchstr(trim(execute('highlight ' . hlgroup)), '\<links\s\+to\>\s\+\zs\w\+$')
  endwhile

  if empty(groupChain)
    echo 'No highlight groups'
    return
  endif

  for group in groupChain
    execute 'highlight' group
  endfor
endfunction

command! -bar Hlgroup call ShowHighlightGroup()
