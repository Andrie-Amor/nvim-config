return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = { "astro", "javascript", "typescript", "html", "css" },
            }
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({})
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
            vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "pattern" },
                patterns = { ".git", "Makefile", "package.json", ".project-root" },
            })
            require("telescope").load_extension("projects")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
            -- Integrate with nvim-cmp if available
            local cmp_status, cmp = pcall(require, "cmp")
            if cmp_status then
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        lazy = false,
        config = function()
            require("nvim-surround").setup({})
        end,
    },
} 
