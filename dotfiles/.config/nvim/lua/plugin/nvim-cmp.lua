local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- 挿入モードの設定
cmp.setup {
  -- 補完にアイコンを表示
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol"
    })
  },
  -- スニペットプラグインにluasnipを使用
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- キーバインドの設定
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- 補完候補が表示されていたときは確定する
      if cmp.visible() then
        cmp.confirm({ select = true })
        -- スニペットが展開できるかジャンプ可能な場合は展開かジャンプする
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        -- それ以外の場合はフォールバックする
      else
        fallback()
      end
    end),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      -- 補完候補が表示されていたときは一つ前を選択する
      if cmp.visible() then
        cmp.select_prev_item()
        -- スニペットがジャンプ可能な場合はジャンプする
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        -- それ以外の場合はフォールバックする
        fallback()
      end
    end),
    -- C-f/bでドキュメントスクロール
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  }),
  -- 補完のソースを選択
  sources = cmp.config.sources({
    -- LSPから補完
    { name = "nvim_lsp" },
    -- スニペットから補完
    { name = "luasnip" },
    -- 補完時にシグネチャを表示
    { name = 'nvim_lsp_signature_help' },
  }, {
    -- バッファから補完
    { name = "buffer" },
  }),
}

-- 検索モードの設定
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    -- シグネチャから補完
    { name = "nvim_lsp_document_symbol" },
  }, {
    -- バッファから補完
    { name = "buffer" },
  })
})

-- コマンドラインモードの設定
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    -- パスから補完
    { name = "path" },
  }, {
    -- コマンドラインから補完
    { name = "cmdline" },
  })
})
