default:
    just --list

serve:
    rojo sourcemap --watch -o sourcemap.json default.project.json \
        & rojo build --watch -p Epoch.rbxm default.project.json \
        & rojo serve serve.project.json
