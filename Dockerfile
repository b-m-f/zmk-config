FROM ghcr.io/zephyrproject-rtos/zephyr-build:latest
RUN pip3 install --user -U west

USER root
RUN mkdir /zmk
WORKDIR /zmk

RUN git clone https://github.com/zmkfirmware/zmk.git .
RUN west init -l app/

ENTRYPOINT ["west"]
