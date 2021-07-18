let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ ]

let g:startify_session_autoload = 1

let g:startify_session_delete_buffers = 1

let g:startify_change_to_vcs_root = 1

let g:startify_fortune_use_unicode = 1

let g:startify_session_persistence = 1

let g:startify_enable_special = 0

let g:startify_custom_header = [
      \'    ____  __                   ____  __                ',
      \'   / __ )/ /__  ___  ____     / __ )/ /___  ____  ____ ',
      \'  / __  / / _ \/ _ \/ __ \   / __  / / __ \/ __ \/ __ \',
      \' / /_/ / /  __/  __/ /_/ /  / /_/ / / /_/ / /_/ / /_/ /',
      \'/_____/_/\___/\___/ .___/  /_____/_/\____/\____/ .___/ ',
      \'                 /_/                          /_/      ',
      \]
