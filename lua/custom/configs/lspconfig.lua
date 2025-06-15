local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

-- C++
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- ✅ Python
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- ✅ CMake
lspconfig.cmake.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

