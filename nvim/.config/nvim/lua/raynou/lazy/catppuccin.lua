return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function ()
    require("catppuccin").setup({
      flavour = "frappe", -- I liked frappe
      transparent_background = true,
      default_integrations = true
    })
  end
}
