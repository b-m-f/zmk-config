init:
    podman build -f Dockerfile -t zmk-builder
    podman run --rm zmk-builder west update
update:
    podman run --rm
