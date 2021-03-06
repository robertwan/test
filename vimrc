set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030

set ts=4
set expandtab

set shiftwidth=4

set clipboard=unnamed
set nocompatible
set nu

call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'alvan/vim-closetag', { 'for' : 'html'  }
Plug 'vim-scripts/a.vim' , { 'for' : ['c','cpp']  }
Plug 'leafgarland/typescript-vim' , { 'for' : 'typescript'  }
Plug 'elzr/vim-json' , { 'for' : 'json'  }
Plug 'fatih/vim-go', { 'for' : 'go'  }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'   }
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jlanzarotta/bufexplorer'
Plug 'mhinz/vim-grepper'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'vim-scripts/Marks-Browser'
Plug 'kshenoy/vim-signature'
Plug 'KeitaNakamura/neodark.vim'

call plug#end()

colorscheme neodark

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

let $FZF_DEFAULT_OPTS ='--bind ctrl-a:select-all,ctrl-d:deselect-all'


"noremap <TAB>m <c-w>\|<c-w>_
""noremap <TAB>+ <C-W>+

let g:ranger_map_keys = 0
map <leader>f :Ranger<CR>

let g:EasyMotion_do_mapping = 0

nmap f <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1


map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

map <Leader>. <Plug>(easymotion-repeat)

nnoremap <C-p> :Files<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>a :Ag<CR>
nnoremap ff :BLines<CR>

nnoremap <C-m> :call QFixToggle(1)<cr>
nmap <silent> <leader_ma :MarksBrowser<cr>


"command! -bang -nargs_a QFix call QFixToggle(<bang>0)


function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced != 0
        cclose
    else
        if exists("g:my_quickfix_win_height")
            execute "copen ".g:my_quickfix_win_height
        else
            copen
        endif
    endif
endfunction

augroup QFixToggle
    autocmd!
    autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
    autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END


let g:rg_command = '
  \ Ag --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

function! VisualSelection() range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    execute 'GrepperAg '.l:pattern.' % '
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <leader>s :call VisualSelection()<CR>  )

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

let g:mwDefaultHighlightingPalette = 'extended'
let g:mwDefaultHighlightingNum = 9
