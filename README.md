# ⚡ static-noise.nvim

> High-contrast dark colorscheme for Neovim (0.9+) with full Tree-sitter, LSP, and plugin support.

**Static Noise** is an electric-pastel dark colorscheme designed for extreme contrast, zero visual fatigue, and crisp code hierarchy.

---

## 📦 Instalación

### Con [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
-- lua/plugins/colorscheme.lua
return {
  {
    "hcastillaq/static-noise.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- Activa/desactiva fondo transparente
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
      },
    },
    config = function(_, opts)
      require("static-noise").setup(opts)
      vim.cmd.colorscheme("static-noise")
    end,
  },
}
```

### Con LazyVim

Si usas [LazyVim](https://lazyvim.org), agrégalo en `lua/plugins/colorscheme.lua`:

```lua
return {
  {
    "hcastillaq/static-noise.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "static-noise",
    },
  },
}
```

---

## ⚙️ Opciones de Configuración

Valores por defecto:

```lua
require("static-noise").setup({
  transparent = true, -- true: hereda el fondo de tu terminal (Ghostty/Alacritty/Kitty)
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
  },
})
```

---

## 🔌 Plugins Soportados

* **Tree-sitter** (Resaltado semántico completo)
* **LSP Diagnostics** (Bordes, virtuales y undercurls)
* **Lualine** (tema detectado automáticamente, con superficie elevada)
* **GitSigns**
* **Neo-tree**
* **Telescope**
* **Which-Key (v3)**
* **Flash.nvim**
* **Trouble.nvim**

---

## 🎨 Fuente de Verdad y Sincronización

Este plugin consume la paleta canónica de [`static-noise`](https://github.com/hcastillaq/static-noise). Los releases etiquetados del repositorio canónico abren automáticamente un PR que sincroniza `lua/static-noise/palette.lua` desde un commit SHA inmutable y registra su procedencia en `UPSTREAM.md`.

---

## 📄 Licencia

MIT License © [Hernan Castilla](https://github.com/hcastillaq)
