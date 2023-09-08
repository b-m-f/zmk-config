update:
    podman run -e WORKSPACE_DIR=/zmk --workdir /zmk -v $PWD/zmk:/zmk zmkfirmware/zmk-build-arm:3.2 west update

get-zmk:
    -git clone https://github.com/zmkfirmware/zmk.git 
    -podman run -e WORKSPACE_DIR=/zmk --workdir /zmk -v $PWD/zmk:/zmk zmkfirmware/zmk-build-arm:3.2 west init -l app/

init: get-zmk update


build-left:
    podman run -v $PWD/zmk:/zmk -v $PWD/config:/config -e WORKSPACE_DIR=/zmk/app --workdir /zmk/app zmkfirmware/zmk-build-arm:3.2 west build -b nice_nano_v2 -- -DSHIELD="splitkb_aurora_sweep_left" -DZMK_CONFIG="/config"

build-right:
    podman run -v $PWD/zmk:/zmk -v $PWD/config:/config -e WORKSPACE_DIR=/zmk/app --workdir /zmk/app zmkfirmware/zmk-build-arm:3.2 west build -b nice_nano_v2 -- -DSHIELD=splitkb_aurora_sweep_right -DZMK_CONFIG="/config"

build: build-left build-right
