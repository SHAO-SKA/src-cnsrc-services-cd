# hardware

## computing nodes

| IP Address      | Hostname    | Role          | Resources      | Storage     |
| --------------- | ----------- | ------------- | -------------  | ----------- |
| 192.168.254.192 | ska132-01   | control-plane | 16 vCPU, 15GB  | 2TB SSD     |
| 192.168.254.193 | ska132-02   | control-plane | 32 vCPU, 62GB  | 2TB SSD     |
| 192.168.254.197 | ska132-03   | control-plane | 32 vCPU, 62GB  | 2TB SSD     |
| 192.168.254.175 | ska132-175  | worker        | 32 vCPU, 754GB | 2TB SSD     |
| 192.168.254.176 | ska132-176  | worker        | 32 vCPU, 754GB | 2TB SSD     |
| 192.168.254.177 | ska132-177  | worker        | 32 vCPU, 754GB | 2TB SSD     |
| 192.168.254.178 | ska132-178  | worker        | 32 vCPU, 754GB | 2TB SSD     |
| 192.168.254.179 | ska132-179  | worker        | 32 vCPU, 754GB | 2TB SSD     |

## external nfs storage cluster provided by huawei

* total storage size: 1PB
* endpoint
    + 192.168.6.66:/share
