return {
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function(_, _)
      vim.cmd([[
        let g:conjure#filetypes = ["clojure"]
      ]])
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
  },
  { "guns/vim-sexp" },
  { "tpope/vim-sexp-mappings-for-regular-people" },
}
