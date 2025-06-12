default:
    just --list

dev $EPOCH_DEV="true":
    darklua process -c .darklua.json -w src dist \
        & rojo sourcemap --watch -o sourcemap.json default.project.json \
        & rojo build --watch -p Epoch.rbxm build.project.json \
        & rojo serve serve.project.json
