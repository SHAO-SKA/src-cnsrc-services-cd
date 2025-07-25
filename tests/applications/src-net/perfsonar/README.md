## Inference
- https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/monitoring-tools/perfsonar.html

## Prerequisites
- [Podman](https://podman.io/) is installed


### Startup
```shell
podman run -td --name perfsonar-testpoint  -p 30443:443  -p 861:861 -p 5201:5201 --privileged --replace --tmpfs /run --tmpfs /run/lock --tmpfs /tmp -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns host container-image-mirror.internal.ska.zverse.space:32443/docker.io/perfsonar/testpoint:systemd

podman run -it --rm --name perfsonar --privileged --entrypoint bash --cgroupns host container-image-mirror.internal.ska.zverse.space:32443/docker.io/perfsonar/testpoint:systemd 

podman run -td --name perfsonar-test --privileged --replace --tmpfs /run --tmpfs /run/lock --tmpfs /tmp -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns host container-image-mirror.internal.ska.zverse.space:32443/docker.io/perfsonar/testpoint:systemd
```


### Running the Connectivity Test 1
```shell
export perfsonar_container_ID=78ed3cd5d7a8
podman exec -it $perfsonar_container_ID pscheduler troubleshoot
```

### Running the Connectivity Test 2
```shell
podman exec -it <$perfsonar_container_ID> pscheduler task --debug throughput --dest perfsonar01.jc.rl.ac.uk
```

### Running the Connectivity Test 3
```shell
podman exec -it <$perfsonar_container_ID> pscheduler task --debug throughput --dest perfsonar.ska.zverse.space
```

### Running the Connectivity Test 4
```shell
# "perfsonar01.jc.rl.ac.uk"
# "bdw-arbutus.computecanada.ca"
# "perfsonar-c.swesrc.chalmers.se"
# "shion-perfsonar.mtk.nao.ac.jp"
# "spsrc32.iaa.csic.es"
# "ps-slough-lat.perf.ja.net"
# "ps-slough-bw.perf.ja.net"
# "perfsonar-bandwidth.grid.surfsara.nl"
# "perfsonar-latency.grid.surfsara.nl"
# "ps-london-bw.perf.ja.net"
# "ps-london-lat.perf.ja.net"
# "ps-3-100g.perfsonar.ac.za"
# "perfsonar.castor.skach.org"
# "perfsonar-01.hpc.cam.ac.uk"
# "perfsonar.srcdev.skao.int"

podman exec -it <$perfsonar_container_ID> pscheduler task --debug throughput --source perfsonar01.jc.rl.ac.uk --dest perfsonar.ska.zverse.space
```

### Check the status of service If it is not running
due to some unknown reason, we need to check iperf3 service manually if the service is not running
```shell
/usr/bin/python3 /usr/lib/pscheduler/daemons/ticker --dsn @/etc/pscheduler/database/database-dsn &
/usr/bin/python3 /usr/lib/pscheduler/daemons/scheduler --dsn @/etc/pscheduler/database/database-dsn &
/usr/bin/python3 /usr/lib/pscheduler/daemons/runner --dsn @/etc/pscheduler/database/database-dsn &
/usr/bin/python3 /usr/lib/pscheduler/daemons/archiver --dsn @/etc/pscheduler/database/database-dsn &
iperf3 -s -p 5201 -D
```

## Test History
### ska132
- 2025-07-24: [troubleshoot.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/perfsonar/test-history/ska132-20250724/troubleshoot.png), [throughput1.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/perfsonar/test-history/ska132-20250724/throughput.png), [throughput2.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/perfsonar/test-history/ska132-20250724/throughput2.png),  [from_uk_to_cn.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/perfsonar/test-history/ska132-20250724/from_uk_to_cn.png), 



