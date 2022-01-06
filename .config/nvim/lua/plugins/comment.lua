require('Comment').setup()

local wk = require('which-key')
wk.register({
    ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<cr>', 'toggle comment' }
}, { prefix = '<leader>' })
wk.register({
    ["/"] = { '<esc><cmd>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<cr>', 'toggle comment' }
}, { prefix = '<leader>', mode = 'v' })
