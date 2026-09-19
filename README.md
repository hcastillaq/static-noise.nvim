# ⚡ static-noise.nvim

Un adaptador instalable para Neovim de **[Static Noise](https://github.com/hcastillaq/static-noise)**: una identidad visual oscura, profunda y eléctrica para herramientas de desarrollo.

Este repositorio no define una paleta independiente. Traduce la paleta original de Static Noise a los grupos de highlights de Neovim y sus plugins. Puedes conocer la paleta y la identidad visual completa en el [proyecto original](https://github.com/hcastillaq/static-noise), antes de explorar su adaptación para Neovim.

A partir de esa base, `static-noise.nvim` añade la integración específica de Neovim. Tiene soporte para:

- Tree-sitter
- LSP Diagnostics
- Lualine
- GitSigns
- Neo-tree
- Telescope
- Which-Key v3
- Flash.nvim
- Trouble.nvim

## Requisitos

- Neovim 0.9 o superior.
- Una terminal con soporte para colores verdaderos (`termguicolors`).

## Instalación

### lazy.nvim

Añade el siguiente bloque a tu configuración:

```lua
{
  "hcastillaq/static-noise.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = { italic = true },
    },
  },
}
```

Después, selecciona el tema:

```lua
vim.cmd.colorscheme("static-noise")
```

### LazyVim

Crea `lua/plugins/colorscheme.lua`:

```lua
return {
  {
    "hcastillaq/static-noise.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "static-noise",
    },
  },
}
```

### Instalación manual

Clona el repositorio dentro de tu directorio de paquetes de Neovim:

```sh
git clone https://github.com/hcastillaq/static-noise.nvim \
  ~/.local/share/nvim/site/pack/colors/start/static-noise.nvim
```

Luego añade a tu configuración:

```lua
vim.cmd.colorscheme("static-noise")
```

## Configuración

Todas las opciones son opcionales:

```lua
require("static-noise").setup({
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
  },
})

vim.cmd.colorscheme("static-noise")
```

### Opciones

- `transparent`: usa el fondo de tu terminal cuando es `true`.
- `styles.comments.italic`: aplica cursiva a los comentarios.
- `styles.keywords.italic`: aplica cursiva a las palabras clave.
- `styles.functions.italic`: aplica cursiva a las funciones.

## Integraciones

`static-noise.nvim` es el colorscheme que proporciona todos estos highlights. Primero instálalo y actívalo:

```lua
require("static-noise").setup({})
vim.cmd.colorscheme("static-noise")
```

El tema solo define colores; no instala ni configura los plugins. Instálalos con tu gestor habitual y carga `static-noise` después de ellos. Si usas `lazy.nvim`, la especificación mínima es:

```lua
{
  "hcastillaq/static-noise.nvim",
  lazy = false,
  priority = 1000,
}
```

### Tree-sitter

Incluye capturas semánticas para variables, funciones, métodos, keywords, tipos, strings, tags y puntuación. Con la API actual de `nvim-treesitter`:

```lua
require("nvim-treesitter").setup({})
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})
```

### LSP Diagnostics

Incluye colores para signos, texto virtual, ventanas flotantes, bordes y undercurls. Solo necesitas configurar tu cliente LSP:

```lua
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  float = { border = "rounded" },
})
```

### Lualine

El tema se detecta automáticamente por su nombre y usa superficies elevadas:

```lua
require("lualine").setup({
  options = { theme = "auto" },
})
```

También puedes seleccionarlo explícitamente con `theme = "static-noise"`.

### Plugins con grupos dedicados

GitSigns, Neo-tree, Telescope, Which-Key v3, Flash.nvim y Trouble.nvim reciben grupos de highlights dedicados. Después de instalarlos, no requieren configuración adicional del colorscheme:

```lua
vim.cmd.colorscheme("static-noise")
```

Sus comandos y mappings siguen siendo los definidos por cada plugin. Por ejemplo, una configuración mínima puede añadir tus propios mappings:

```lua
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
```

## Licencia

MIT © [Hernan Castilla](https://github.com/hcastillaq)
