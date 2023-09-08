update:
    podman run -e WORKSPACE_DIR=/zmk --workdir /zmk -v $PWD/zmk:/zmk zmkfirmware/zmk-build-arm:3.2 west update

get-zmk:
    -git clone https://github.com/zmkfirmware/zmk.git 
    -podman run -e WORKSPACE_DIR=/zmk --workdir /zmk -v $PWD/zmk:/zmk zmkfirmware/zmk-build-arm:3.2 west init -l app/

init: get-zmk update


build-left:
    podman run -v $PWD/zmk:/zmk -v $PWD/config:/config -e WORKSPACE_DIR=/zmk/app --workdir /zmk/app zmkfirmware/zmk-build-arm:3.2 west build -b nice_nano_v2 -- -DSHIELD="splitkb_aurora_sweep_left" -DZMK_CONFIG="/config"
    mv zmk/app/build/zephyr/zmk.uf2 result/left.uf2

build-right:
    podman run -v $PWD/zmk:/zmk -v $PWD/config:/config -e WORKSPACE_DIR=/zmk/app --workdir /zmk/app zmkfirmware/zmk-build-arm:3.2 west build -b nice_nano_v2 -- -DSHIELD=splitkb_aurora_sweep_right -DZMK_CONFIG="/config"
    mv zmk/app/build/zephyr/zmk.uf2 result/right.uf2

create-build-output-dir:
    -rm -rf result
    mkdir result

build: create-build-output-dir build-left build-right
