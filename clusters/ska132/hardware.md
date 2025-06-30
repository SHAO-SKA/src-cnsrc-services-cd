# hardware

## computing nodes

| IP Address      | Hostname    | Role          | Resources     | Storage     |
| --------------- | ----------- | ------------- | ------------- | ----------- |
| 192.168.254.192 | ska132-01   | control-plane | 16 vCPU, 15GB | 2TB SSD     |
| 192.168.254.xxx | ska132-xx   | control-plane | xx vCPU, xxGB | 2TB SSD     |
| 192.168.254.xxx | ska132-xx   | control-plane | xx vCPU, xxGB | 2TB SSD     |
| 192.168.254.178 | ska132-02   | worker        | 16 vCPU, 15GB | 2TB SSD     |
| 192.168.254.179 | ska132-03   | worker        | 32 vCPU, 62GB | 2TB SSD     |

## external nfs storage cluster provided by huawei

* total storage size: 1PB
* endpoint
    + 192.168.6.66:/share
