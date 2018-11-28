call shortcut#map('<Space> h <Tab>', 'Format -> Indent -> Tabs')
call shortcut#map('<Space> h <Space>', 'Format -> Indent -> Spaces')
call shortcut#map('<Space> h 1', 'Format -> Markdown -> Title')
call shortcut#map('<Space> h 2', 'Format -> Markdown -> Section')
call shortcut#map('<Space> h t', 'Format -> Markdown -> Table header')
call shortcut#map('<Space> h c', 'Format -> Markdown -> Fenced code block')
call shortcut#map('<Space> h =', 'Format -> Separator -> Using equal sign')
call shortcut#map('<Space> h -', 'Format -> Separator -> Using minus sign')
call shortcut#map('<Space> h $', 'Format -> Separator -> Repeat .$ to EOL')
call shortcut#map('<Space> h w', 'Format -> Pencil -> Soft wrap', 'PencilSoft')
call shortcut#map('<Space> h W', 'Format -> Pencil -> Hard wrap', 'PencilHard')
call shortcut#map('<Space> h a', 'Format -> Arguments -> Toggle multi-line', 'ArgWrap')
call shortcut#map('<Space> h s', 'Format -> Convert -> Cycle through delimiters', 'Switch')
call shortcut#map('<Space> h <', 'Format -> Convert -> Function call to pipeline')
call shortcut#map('<Space> h >', 'Format -> Convert -> Pipeline to function call')
call shortcut#map("<Space> h '", 'Format -> Convert -> Double to single quotes')
call shortcut#map('<Space> h "', 'Format -> Convert -> Single to double quotes')
call shortcut#map('<Space> h :', 'Format -> Convert -> Single quotes to Ruby symbol')
call shortcut#map('<Space> h ;', 'Format -> Convert -> Ruby symbol to single quotes')
call shortcut#map('<Space> h )', 'Format -> Parentheses -> Add')
call shortcut#map('<Space> h (', 'Format -> Parentheses -> Remove')

" automatically adjust indentation style based on the buffer we are editing
autocmd BufReadPost * call s:DetectIndentationStyle()
function! s:DetectIndentationStyle()
  if search('^\t\+ *\S', 'ncw')
    call Shortcut_format_indent_tabs()
  else
    call Shortcut_format_indent_spaces()
  endif
endfunction

function! Shortcut_format_indent_tabs() abort
  setlocal noexpandtab softtabstop=8 shiftwidth=8
endfunction

function! Shortcut_format_indent_spaces() abort
  setlocal expandtab softtabstop=2 shiftwidth=2
endfunction

" format current line as a top-level heading in Markdown
" yyp:s/^\s*//<Return>Vr===:.+g/^\s*=\+\s*/d
function! Shortcut_format_markdown_title() abort
  let cursor = winsaveview()

  " duplicate current line into new separator line
  normal! yyp

  " strip leading whitespace from separator line
  s/^\s*//

  " make all characters "=" in separator line
  normal! Vr=

  " indent separator line to line up with title
  normal! ==

  " delete any previously existing separator line
  .+g/^\s*=\+\s*/d

  call winrestview(cursor)
endfunction

" format current line as a second-level heading in Markdown
" yyp:s/^\s*//<Return>Vr-==:.+g/^\s*-\+\s*/d
function! Shortcut_format_markdown_section() abort
  let cursor = winsaveview()

  " duplicate current line into new separator line
  normal! yyp

  " strip leading whitespace from separator line
  s/^\s*//

  " make all characters "-" in separator line
  normal! Vr-

  " indent separator line to line up with title
  normal! ==

  " delete any previously existing separator line
  .+g/^\s*-\+\s*/d

  call winrestview(cursor)
endfunction

" format current line as table/body separator in Markdown (uses `z marker)
function! Shortcut_format_markdown_table_header() abort
  let cursor = winsaveview()

  " duplicate current line into new separator line
  normal! yyp

  " strip leading whitespace from separator line
  left

  " make all characters "-" and "|" in separator line
  s/[^|]/-/g
  s/-|/ |/g
  s/|-/| /g

  " indent separator line to line up with title
  normal! ==

  " delete any previously existing separator line
  .+g/^\s*[|-]\+\s*/d

  call winrestview(cursor)
endfunction

" format selected Markdown indented code block into a fenced code block
" 2<']o<Esc>3i`<Esc>yy<C-O>PA
function! Shortcut_format_markdown_fenced_code_block() abort
  if shortcut#mode() == 'n'
    normal! V
  endif
  normal! 2<'>2o
  normal! 3i`
  normal! kddyy'<P$
endfunction

" insert or update section separator at end of current line
function! Shortcut_format_separator_using_equal_sign() abort
  normal! A=
  call Shortcut_format_separator_repeat_to_eol()
endfunction

" insert or update section separator at end of current line
function! Shortcut_format_separator_using_minus_sign() abort
  normal! A-
  call Shortcut_format_separator_repeat_to_eol()
endfunction

" repeat last character to the maximum width of current line
function! Shortcut_format_separator_repeat_to_eol() abort
  let last_search_register=@/
  try
    execute 's/.$/'. repeat('&', &textwidth+1) .'/'
    execute 's/\%>'. &textwidth .'v.//g'
  finally
    let @/=last_search_register
  endtry
endfunction

" extract function call arguments into an Elixir pipeline
function! Shortcut_format_convert_function_call_to_pipeline() abort
  let cursor = winsaveview()

  " extract function call arguments
  normal di)

  " paste them BEFORE function call
  execute "normal! BPa |> "

  " delete function call parentheses
  normal da)

  call winrestview(cursor)
endfunction

" convert Elixir pipeline stage into function call arguments
function! Shortcut_format_convert_pipeline_to_function_call() abort
  let cursor = winsaveview()

  " delete next pipeline operator
  if search('|>', 'c', line('.')) || search('|>', 'bc', line('.'))
    normal! dwge

    " cut out the pipeline stage
    if search('\v(\|>|[=\(])\s*', 'bsWe')
      normal! wv`'d
    else
      normal! vBd
    endif

    " append a pair of parentheses
    normal! Ea()

    " paste what we cut out earlier
    normal! P
  endif

  call winrestview(cursor)
endfunction

" convert from double quotes to single quotes
function! Shortcut_format_convert_double_to_single_quotes() abort
  let cursor = winsaveview()
  normal cs"'
  call winrestview(cursor)
endfunction

" convert from single quotes to double quotes
function! Shortcut_format_convert_single_to_double_quotes() abort
  let cursor = winsaveview()
  normal cs'"
  call winrestview(cursor)
endfunction

" convert from single quotes to Ruby symbol notation
function! Shortcut_format_convert_single_quotes_to_ruby_symbol() abort
  let cursor = winsaveview()
  normal ds'
  normal! i:
  call winrestview(cursor)
endfunction

" convert from Ruby symbol notation to single quotes
function! Shortcut_format_convert_ruby_symbol_to_single_quotes() abort
  let cursor = winsaveview()
  normal! F:xve
  normal s'
  call winrestview(cursor)
endfunction

" surround function call arguments with parentheses
function! Shortcut_format_parentheses_add() abort
  let cursor = winsaveview()

  if shortcut#mode() == 'n'
    " put cursor at the end of the word under cursor
    normal! gee

    " select back to WORD preferably ending in comma
    normal! vF,
    normal! B
  endif

  " surround the visual selection with parentheses
  normal s)

  " remove extraneous space at left of parentheses
  normal! X

  call winrestview(cursor)
endfunction

" remove parentheses around function call arguments
function! Shortcut_format_parentheses_remove() abort
  let cursor = winsaveview()
  normal ds)
  execute 'normal! i '
  call winrestview(cursor)
endfunction
