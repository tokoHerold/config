local set = vim.keymap.set

set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')
set({'n', 'x', 'o'}, '<a-s>', '<Plug>(leap)')
set('n',             'gs', '<Plug>(leap-from-window)')
