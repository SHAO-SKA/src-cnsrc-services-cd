# haproxy

## hardware

1. use machine(192.168.6.198) to install haproxy
2. network rules
    * port `443` will be remapped as `202.127.3.156:443`

## usage

1. git clone this repository
2. start
    * ```shell
      bash clusters/ska132/haproxy/start.sh
      ```
3. reload
    * ```shell
      bash clusters/ska132/haproxy/reload.sh
      ```
