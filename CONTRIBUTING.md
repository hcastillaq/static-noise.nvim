# Contributing

## Probar el tema con plugins

La imagen copia el repositorio a `/workspace`, ejecuta el build y después instala únicamente el runtime del plugin en:

```text
/root/.local/share/nvim/site/pack/colors/start/static-noise.nvim
```

También instala una configuración mínima con `lazy.nvim` y las integraciones que el tema soporta:

- Tree-sitter
- Telescope
- Lualine
- GitSigns
- Neo-tree
- Which-Key
- Flash.nvim
- Trouble.nvim

Construye la imagen:

```sh
docker build -f Dockerfile.dev -t static-noise-dev .
```

Inicia el contenedor con una shell:

```sh
docker run --rm -it static-noise-dev
```

Dentro del contenedor, ejecuta Neovim:

```sh
nvim
```

Atajos disponibles:

```text
<Space>e   Árbol de archivos
<Space>ff  Buscar archivos
<Space>xx  Diagnósticos
s           Flash jump
```

Para probar cambios nuevos hay que reconstruir la imagen:

```sh
docker build -f Dockerfile.dev -t static-noise-dev .
```

El contenedor está pensado para desarrollo y verificación. La instalación del tema para usuarios finales se documenta en `README.md`.
