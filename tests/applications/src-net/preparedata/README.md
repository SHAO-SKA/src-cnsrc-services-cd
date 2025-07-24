## Inference
- https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/preparedata/preparedata.html

## Prerequisites
- [Prepare Data Service](https://gitlab.com/ska-telescope/src/src-dm/ska-src-dm-local-data-preparer/)  is up
- SODA Service has already processed the same data, e.g. pi24_run_1_cleaned_reupload.fits
- [Gatekeeper](https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/authorization/gatekeeper.html) service is up


### Environment Variables Setup
Set the environment variable "SKA_TOKEN". 
```bash
srcnet-oper token request

srcnet-oper token get authn-api

export SKA_TOKEN=xxxx.xxx
```

### Running the Connectivity Test

```bash
# root@ska132-01:~# kubectl -n preparedata get svc
# NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)              AGE
# preparedata-service   NodePort    10.102.66.217    <none>        8000:31425/TCP       14d

# using preparedata service directly
curl -k -X 'POST' http://192.168.254.178:31425 -H "Authorization: Bearer $SKA_TOKEN" -H 'accept: application/json' -H 'Content-Type: application/json' -d '[[ "chocolate:pi24_run_1_cleaned_reupload.fits","chocolate/da/56/pi24_run_1_cleaned_reupload.fits","./chocolate"]]'

# integrate with gatekeeper
curl -X 'POST' https://gatekeeper.ska.zverse.space/preparedata -H "Authorization: Bearer $SKA_TOKEN" -H 'accept: application/json' -H 'Content-Type: application/json' -d '[[ "chocolate:pi24_run_1_cleaned_reupload.fits","chocolate/da/56/pi24_run_1_cleaned_reupload.fits","./chocolate"]]'
# you will get a taskID
export TASK_ID=xxxx

# using preparedata service directly
curl -k -X 'GET' http://192.168.254.178:31425/$TASK_ID -H 'accept: application/json' -H "Authorization: Bearer $SKA_TOKEN"
# integrate with gatekeeper
curl -X 'GET' https://gatekeeper.ska.zverse.space/preparedata/$TASK_ID -H 'accept: application/json' -H "Authorization: Bearer $SKA_TOKEN"
```

## Test History
### ska132
- 2025-07-23: [step1.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/preparedata/test-history/ska132-20250723/step1.png), [result1.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/preparedata/test-history/ska132-20250723/result1.png)