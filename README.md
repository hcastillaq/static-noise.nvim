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
* **GitSigns**
* **Neo-tree**
* **Telescope**
* **Which-Key (v3)**
* **Flash.nvim**
* **Trouble.nvim**

---

## 🎨 Fuente de Verdad y Sincronización

Este plugin consume los tokens cromáticos canónicos definidos en el repositorio base [`static-noise`](https://github.com/hcastillaq/static-noise). 

Para los mantenedores, los colores **nunca se editan a mano**. Se actualizan ejecutando el script de sincronización:

```bash
./scripts/sync-palette.sh
```

El script consulta la salida compilada de `static-noise` (local o remota vía GitHub) y regenera `lua/static-noise/palette.lua` de forma 100% automatizada.

---

## 📄 Licencia

MIT License © [Hernan Castilla](https://github.com/hcastillaq)
